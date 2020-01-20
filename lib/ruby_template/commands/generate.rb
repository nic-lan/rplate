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

        StoreEntity.call(filename, entity_view)
      end

      private

      attr_reader :entity
    end
  end
end
