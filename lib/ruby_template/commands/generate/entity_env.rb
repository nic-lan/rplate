# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      class EntityEnv
        class Error < StandardError; end

        TEMPLATES = {
          default: {
            layout: 'templates/entity/layout.erb',
            module: 'templates/entity/module.erb',
            resource: 'templates/entity/resource.erb',
            method: 'templates/entity/method.erb'
          },
          spec: {
            layout: 'templates/entity_spec/layout.erb',
            resource: 'templates/entity_spec/resource.erb',
            method: 'templates/entity_spec/method.erb'
          }
        }.freeze

        attr_reader :env

        def initialize(env)
          raise Error, 'Invalid Env' unless TEMPLATES[env]

          @env = env
        end

        def templates
          @_templates ||= TEMPLATES[env]
        end
      end
    end
  end
end
