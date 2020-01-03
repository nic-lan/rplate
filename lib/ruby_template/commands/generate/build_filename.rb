# frozen_string_literal: true

module RubyTemplate
  module Commands
    class Generate
      #
      # BuildFilename is the class responsible to define the filename given an entity name
      #
      # @example Simple entity name
      #     MyClass #=> lib/my_class.rb
      #
      # @example Scoped entity name
      #     Whatever::MyClass #=> lib/whatever/my_class.rb
      class BuildFilename
        #
        # @param entity_name [Object] The entity we want to generate the filename from
        # @return [String] The built filename
        def self.call(entity)
          "#{entity.root}/#{entity.name}.rb".underscore
        end
      end
    end
  end
end
