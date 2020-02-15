# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      #
      # Generate is the ValidateParams for the Generate Command
      class ValidateParams < Dry::Validation::Contract
        ALLOWED_NAME_REGEX = /\A[a-z][a-z0-9_]*\z/.freeze
        ALLOWED_TYPES = %w[class module].freeze
        ALLOWED_METHODS_REGEX = /(self.)?([a-z]+_?)/.freeze
        ALLOWED_INFLECTIONS_REGEX = /[a-z]\w*:[A-Z]\w*/.freeze

        params do
          required(:entity_names).value(:array, min_size?: 1).each(:str?,
                                                                   format?: ALLOWED_NAME_REGEX)
          required(:type).filled(included_in?: ALLOWED_TYPES)
          required(:required_methods).array(:str?, format?: ALLOWED_METHODS_REGEX)
          required(:inflections).array(:str?, format?: ALLOWED_INFLECTIONS_REGEX)
          optional(:root)
        end

        rule(:inflections) do
          InflectionsRule.validate(value, key)
        end

        def self.call(entity_names, options)
          new.call options.merge(entity_names: entity_names)
        end
      end
    end
  end
end
