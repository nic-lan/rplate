# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      Context = Struct.new(:templates, :opts) do
        class << self
          def create(entity, env:)
            new(env.templates, build_opts(entity, env))
          end

          private

          def build_opts(entity, env)
            {
              env: env.env,
              entity_constants: EntityConstants.fetch(entity)
            }
          end
        end
      end
    end
  end
end
