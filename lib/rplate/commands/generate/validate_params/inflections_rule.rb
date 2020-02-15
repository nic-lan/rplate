# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      class ValidateParams
        class InflectionsRule
          def self.validate(inflections, key)
            new(inflections, key).validate
          end

          def initialize(inflections, key)
            @inflections = inflections
            @key = key
            @store = Set.new
          end

          def validate
            inflections.each do |inflection|
              inflection.split(':').each do |inflection_tail|
                check_value(inflection_tail)
              end
            end
          end

          private

          attr_reader :inflections, :key, :store

          def check_value(value)
            return if store.add?(value)

            key.failure("Given inflection `#{value}` is duplicated")
          end
        end
      end
    end
  end
end
