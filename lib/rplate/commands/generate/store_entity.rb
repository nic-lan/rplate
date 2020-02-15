# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      #
      # StoreEntity is the class responsible for:
      # => storing an entity_view string into a file with the given filename
      # => applying existing rubocops
      class StoreEntity
        # GEM_ROOT_PATH needs to be defined here as constant
        # This allow the path to be evaluated from inside the gem and not from where the gem is run
        RUBOCOP_FILE_PATH = "#{RPlate.gem_root_path.freeze}/.rubocop.yml"

        def self.call(filename, entity, context)
          new(filename, entity, context).call if AskOverwrite.confirm?(filename)
        end

        def initialize(filename, entity, context)
          @filename = filename
          @entity = entity
          @context = context
        end

        def call
          entity_view = BuildView.call(entity, context)

          File.open(filename, 'w') { |f| f.write(entity_view) }

          RuboCop::CLI.new.run([filename, '-a', '-c', RUBOCOP_FILE_PATH])
        end

        private

        attr_reader :filename, :entity, :context
      end
    end
  end
end
