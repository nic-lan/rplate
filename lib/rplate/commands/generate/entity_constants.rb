# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      # The EntityContants class is responsible for:
      # => returning the opts for the default context given an entity
      class EntityConstants
        SPLIT_REGEX = %r{:{1,2}|\/}.freeze
        CONSTANT_REGEX = /(?<constant>[A-Za-z]\w*)/.freeze
        ALLOWED_NAME_REGEX = /\A#{CONSTANT_REGEX}(#{SPLIT_REGEX}#{CONSTANT_REGEX})*\z/.freeze

        class << self
          def fetch(entity)
            entity.name.split(SPLIT_REGEX).map(&:camelize)
          end
        end
      end
    end
  end
end
