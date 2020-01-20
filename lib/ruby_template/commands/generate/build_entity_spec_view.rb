# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      # BuildEntitySpecView is the class responsible to create the entity spec view to be saved on file
      class BuildEntitySpecView
        LAYOUT_TEMPLATE = 'templates/entity_spec/layout.erb'
        RESOURCE_TEMPLATE = 'templates/entity_spec/resource.erb'
        METHOD_TEMPLATE = 'templates/entity_spec/method.erb'

        ENTITIES_SPLIT = '::'

        def self.call(entity)
          new(entity).call
        end

        def initialize(entity)
          @entity = entity
        end

        def call
          BuildView.call(
            entity,
            build_entity_resources,
            layout: LAYOUT_TEMPLATE,
            module: MODULE_TEMPLATE,
            resource: RESOURCE_TEMPLATE,
            method: METHOD_TEMPLATE
          )
        end

        private

        attr_reader :entity

        def build_entity_resources
          entity.name.split(ENTITIES_SPLIT)
        end
      end
    end
  end
end
