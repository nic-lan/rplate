# frozen_string_literal: true

module RubyTemplate
  module Commands
    #
    # Generate is the command class responsible to generate the ruby file
    class Generate
      class Entity < OpenStruct; end

      def self.call(entity_name, options)
        validation_result = Commands::Generate::ValidateParams.call(entity_name, options)

        return new(validation_result.output).call if validation_result.success?

        # Test this scenario
        validation_result.messages
      end

      def initialize(entity)
        @entity = Entity.new(entity)
      end

      def call
        entity_view = BuildEntityView.call(entity)
        filename = BuildFilename.call(entity)

        build_nested_dirs(filename)

        File.open(filename, 'w') { |f| f.write(entity_view) }
        puts 'hello'
        system('rubocop', filename, '-a')
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
