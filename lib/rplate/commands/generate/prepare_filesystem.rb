# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      #
      # StoreEntity is the class responsible for:
      # => storing an entity_view string into a file with the given filename
      # => applying existing rubocops
      class PrepareFilesystem
        def self.call(entity, context)
          filename = BuildFilename.call(entity, context.opts)

          path = filename.split('/')
          path.pop
          to_create_path = path.join('/')
          FileUtils.mkdir_p(to_create_path)

          filename
        end
      end
    end
  end
end
