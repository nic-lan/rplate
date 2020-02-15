# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      class BuildView
        class Inflections
          def initialize(inflections)
            @inflections = build_inflection_map(inflections)
          end

          def map(name)
            inflections[name] || name.camelize
          end

          private

          attr_reader :inflections

          def build_inflection_map(inflections)
            inflections.each_with_object({}) do |inflection, map|
              underscored, constantized = *inflection.split(':')

              map[underscored] = constantized
            end
          end
        end
      end
    end
  end
end
