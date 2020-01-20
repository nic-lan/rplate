# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      # BuildEntityView is the class responsible to create the entity view to be saved on file
      class BuildEntityView
        LAYOUT_TEMPLATE = 'templates/entity/layout.erb'
        MODULE_TEMPLATE = 'templates/entity/module.erb'
        RESOURCE_TEMPLATE = 'templates/entity/resource.erb'
        METHOD_TEMPLATE = 'templates/entity/method.erb'

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
