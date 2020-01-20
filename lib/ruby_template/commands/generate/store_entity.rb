module RubyTemplate
  module Commands
    class Generate
      class StoreEntity
        def self.call(filename, entity_view)
          path = filename.split('/')
          path.pop
          FileUtils.mkdir_p(path.join('/'))

          File.open(filename, 'w') { |f| f.write(entity_view) }
          RuboCop::CLI.new.run([filename, '-a'])
        end
      end
    end
  end
end
