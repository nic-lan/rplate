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
            entity_constants_copy = Marshal.load(Marshal.dump(entity_constants))

            render(entity_constants_copy)
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
        #   =>  when the current resource happens to last element in current_entity_constants,
        #         then the entity template is rendered by calling `render_entity`
        def render(current_entity_constants)
          return render_entity(current_entity_constants.join('::')) if opts[:env] == :spec

          current_constant = current_entity_constants.shift
          return render_entity(current_constant) if current_entity_constants.empty?

          render_namespace(current_constant) do
            render(current_entity_constants)
          end
        end

        def render_namespace(current_constant)
          namespace = Namespace.new(current_constant, entity_constants, entity.root)

          template(templates[:module]).render(namespace) do
            yield
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
