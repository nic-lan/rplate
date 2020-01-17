# frozen_string_literal: true

module RubyTemplate
  module Commands
    #
    # Generate is the command class responsible to generate the ruby file
    class Generate
      class Entity < OpenStruct; end

      class Error < StandardError; end

      def self.call(entity_name, options)
        validation_result = Commands::Generate::ValidateParams.call(entity_name, options)

        raise Error, validation_result.messages unless validation_result.success?

        new(validation_result.output).call
      end

      def initialize(entity)
        @entity = Entity.new(entity)
      end

      def call
        entity_view = BuildEntityView.call(entity)
        filename = BuildFilename.call(entity)
        

        build_nested_dirs(filename)

        File.open(filename, 'w') { |f| f.write(entity_view) }
        RuboCop::CLI.new.run([filename, '-a'])
      end

      private

      attr_reader :entity

      def build_nested_dirs(filename)
        path = filename.split('/')
        path.pop
        FileUtils.mkdir_p(path.join('/'))
      end
    end
  end
end
