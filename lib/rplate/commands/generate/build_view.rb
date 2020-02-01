# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      # BuildEntityView is the class responsible to create the entity view to be saved on file
      class BuildView
        ERB_OPTS = { trim: 0 }.freeze

        # GEM_ROOT_PATH needs to be defined here as constant
        # This allow the path to be evaluated from inside the gem and not from where the gem is run
        GEM_ROOT_PATH = RPlate.gem_root_path.freeze

        Namespace = Struct.new(:name)
        Method = Struct.new(:name)
        Resource = Struct.new(:name, :type)

        def self.call(entity, templates = {}, opts = {})
          new(entity, templates, opts).call
        end

        def initialize(entity, templates, opts)
          @entity = entity
          @opts = opts
          @templates = templates
        end

        def call
          template(templates[:layout]).render do
            render(entity_constants)
          end
        end

        private

        attr_reader :entity, :templates, :opts

        def entity_constants
          @_entity_constants ||= opts[:entity_constants] || []
        end

        def template(template)
          template_path = "#{GEM_ROOT_PATH}/#{template}"
          Tilt::ERBTemplate.new(template_path, ERB_OPTS)
        end

        # `render` method is:
        #   =>  recursive when the current resource is a namespace.
        #   =>  when the current resource happens to last element in entity_constants,
        #         then the entity template is rendered by calling `render_entity`
        def render(entity_constants)
          return render_entity(entity_constants.join('::')) if opts[:env] == :spec

          current_resource = entity_constants.shift
          return render_entity(current_resource) if entity_constants.empty?

          namespace = Namespace.new(current_resource)

          template(templates[:module]).render(namespace) do
            render(entity_constants)
          end
        end

        def render_entity(entity_name)
          resource = Resource.new(entity_name, entity.type)

          template(templates[:resource]).render(resource) do
            render_methods
          end
        end

        def render_methods
          entity
            .required_methods
            .map { |method_name| render_method(method_name) }
            .join("\n")
        end

        def render_method(method_name)
          method = Method.new(method_name)

          template(templates[:method]).render(method)
        end
      end
    end
  end
end
