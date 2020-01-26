# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      #
      # StoreEntity is the class responsible for:
      # => storing an entity_view string into a file with the given filename
      # => applying existing rubocops
      class StoreEntity
        def self.call(filename, entity_view)
          path = filename.split('/')
          path.pop
          to_create_path = path.join('/')
          FileUtils.mkdir_p(to_create_path)

          File.open(filename, 'w') { |f| f.write(entity_view) }
          RuboCop::CLI.new.run([filename, '-a'])
        end
      end
    end
  end
end
