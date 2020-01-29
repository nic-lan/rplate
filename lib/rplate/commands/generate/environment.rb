# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      # The Environment defines the allowed environments for the Generate command
      class Environment
        class Error < StandardError; end

        TEMPLATES_DIR = 'templates'

        TEMPLATES = {
          default: {
            layout: "#{TEMPLATES_DIR}/entity/layout.erb",
            module: "#{TEMPLATES_DIR}/entity/module.erb",
            resource: "#{TEMPLATES_DIR}/entity/resource.erb",
            method: "#{TEMPLATES_DIR}/entity/method.erb"
          },
          spec: {
            layout: "#{TEMPLATES_DIR}/entity_spec/layout.erb",
            resource: "#{TEMPLATES_DIR}/entity_spec/resource.erb",
            method: "#{TEMPLATES_DIR}/entity_spec/method.erb"
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
