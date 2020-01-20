# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      # BuildEntityView is the class responsible to create the entity view to be saved on file
      class BuildView
        ERB_OPTS = { trim: 0 }.freeze

        Namespace = Struct.new(:name)
        Method = Struct.new(:name)
        Resource = Struct.new(:name, :type)

        def self.call(entity, entity_resources, templates = {})
          new(entity, entity_resources, templates).call
        end

        def initialize(entity, entity_resources, templates)
          @entity = entity
          @entity_resources = entity_resources
          @templates = templates
        end

        def call
          template(templates[:layout]).render do
            render(entity_resources)
          end
        end

        private

        attr_reader :entity, :entity_resources, :templates

        def template(template)
          Tilt::ERBTemplate.new(template, ERB_OPTS)
        end

        # `render` method is:
        #   =>  recursive when the current resource is a namespace.
        #   =>  when the current resource happens to last element in entity_resources,
        #         then the entity template is rendered by calling `render_entity`
        def render(entity_resources)
          current_resource = entity_resources.shift

          return render_entity(current_resource) if entity_resources.empty?

          namespace = Namespace.new(current_resource)

          template(templates[:module]).render(namespace) do
            render(entity_resources)
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
