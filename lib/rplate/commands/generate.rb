# frozen_string_literal: true

module RPlate
  module Commands
    #
    # Generate is the command class responsible to generate the ruby file
    class Generate
      class Entity < OpenStruct; end

      class Error < StandardError; end

      CONTEXTS = [
        Context.new(:default),
        Context.new(:spec)
      ].freeze

      def self.call(entity_names, options)
        validation_result = Commands::Generate::ValidateParams.call(
          entity_names, options
        )

        return new(validation_result.to_h).call if validation_result.success?

        RPlate::Logger.info(validation_result.errors.to_h)
      end

      def initialize(entity)
        @entity = Entity.new(entity)
      end

      def call
        CONTEXTS.each do |context|
          filename = PrepareFilesystem.call(entity, context)

          StoreEntity.call(filename, entity, context)
        end
      end

      private

      attr_reader :entity
    end
  end
end
