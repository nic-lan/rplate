# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      # The EntityContants class is responsible for:
      # => returning the opts for the default context given an entity
      class EntityConstants
        SPLIT_REGEX = %r{:{1,2}|\/}.freeze

        def self.fetch(entity)
          entity.name.split(SPLIT_REGEX).map(&:camelize)
        end
      end
    end
  end
end
