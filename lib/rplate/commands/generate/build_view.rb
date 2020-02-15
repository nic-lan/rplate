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

        def self.call(entity, context)
          new(entity, context).call
        end

        def initialize(entity, context)
          @entity = entity
          @context = context
          @inflections = Inflections.new(entity.inflections)
        end

        def call
          template(templates[:layout]).render do
            render(entity_constants)
          end
        end

        private

        attr_reader :entity, :context, :inflections

        def templates
          @_templates ||= context.templates
        end

        def env
          @_env ||= context.env
        end

        def entity_constants
          @_entity_constants ||= entity.entity_names.map { |name| @inflections.map(name) }
        end

        def template(template)
          template_path = "#{GEM_ROOT_PATH}/#{template}"
          Tilt::ERBTemplate.new(template_path, ERB_OPTS)
        end

        # `render` method is:
        #   =>  recursive when the current resource is a namespace.
        #   =>  when the current resource happens to last element in remaining_constants,
        #         then the entity template is rendered by calling `render_resource`
        def render(remaining_constants)
          return render_resource(remaining_constants.join('::')) if env == :spec

          current_constant = remaining_constants.shift
          return render_resource(current_constant) if remaining_constants.empty?

          render_namespace(current_constant) do
            render(remaining_constants)
          end
        end

        def render_namespace(current_constant)
          namespace = Namespace.new(current_constant, entity_constants, entity.root)

          template(templates[:module]).render(namespace) do
            yield
          end
        end

        def render_resource(resource_name)
          resource = Resource.new(resource_name, entity.type)

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
