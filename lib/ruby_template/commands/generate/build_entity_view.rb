# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      # BuildEntityView is the class responsible to create the entity view to be saved on file
      class BuildEntityView
        LAYOUT_TEMPLATE = 'templates/entity/layout.erb'
        MODULE_TEMPLATE = 'templates/entity/module.erb'
        RESOURCE_TEMPLATE = 'templates/entity/resource.erb'
        ERB_OPTS = { trim: 0 }.freeze
        ENTITIES_SPLIT = '::'

        Namespace = Struct.new(:name)
        Resource = Struct.new(:name, :type)

        def self.call(entity)
          new(entity).call
        end

        def initialize(entity)
          @entity = entity
        end

        def call
          entity_resources = build_entity_resources

          template(LAYOUT_TEMPLATE).render do
            render(entity_resources)
          end
        end

        private

        attr_reader :entity

        def build_entity_resources
          entity.name.split(ENTITIES_SPLIT)
        end

        def template(template)
          Tilt::ERBTemplate.new(template, ERB_OPTS)
        end

        def render(entity_resources)
          current_resource = entity_resources.shift

          return render_entity(current_resource) if entity_resources.empty?

          namespace = Namespace.new(current_resource)

          template(MODULE_TEMPLATE).render(namespace) do
            render(entity_resources)
          end
        end

        def render_entity(entity_name)
          resource = Resource.new(entity_name, entity.type)

          template(RESOURCE_TEMPLATE).render(resource)
        end
      end
    end
  end
end
