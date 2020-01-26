# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      #
      # Generate is the ValidateParams for the Generate Command
      class ValidateParams
        include Hanami::Validations

        ALLOWED_NAME_REGEX = /([a-zA-Z]+)(:{2}|_)?/.freeze
        ALLOWED_TYPES = %w[class module].freeze
        ALLOWED_METHODS_REGEX = /(self.)?([a-z]+_?)/.freeze

        validations do
          required(:name) { str? & format?(ALLOWED_NAME_REGEX) }
          required(:type) { str? & included_in?(ALLOWED_TYPES) }
          required(:required_methods) do
            array? { each { str? & format?(ALLOWED_METHODS_REGEX) } }
          end
        end

        def self.call(class_name, options)
          options = options.deep_symbolize_keys.merge(name: class_name)

          new(options).validate
        end
      end
    end
  end
end
