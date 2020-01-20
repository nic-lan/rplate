# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      Context = Struct.new(:templates, :opts) do
        class << self
          def create(entity, env:)
            new(env.templates, build_opts(entity, env))
          end

          private

          def build_opts(entity, env)
            build_additional_opts(entity, env.env).merge(env: env.env)
          end

          def build_additional_opts(entity, env)
            return {} if env == :spec

            { entity_resources: entity.name.split('::') }
          end
        end
      end
    end
  end
end
