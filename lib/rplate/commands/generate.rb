# frozen_string_literal: true

module RPlate
  module Commands
    #
    # Generate is the command class responsible to generate the ruby file
    class Generate
      class Entity < OpenStruct; end
      class Error < StandardError; end

      ENTITY_ENVS = [
        Environment.new(:default),
        Environment.new(:spec)
      ].freeze

      def self.call(entity_name, options)
        validation_result = Commands::Generate::ValidateParams.call(
          entity_name, options
        )

        raise Error, validation_result.messages unless validation_result.success?

        new(validation_result.output).call
      end

      def initialize(entity)
        @entity = Entity.new(entity)
      end

      def call
        ENTITY_ENVS
          .map { |entity_env| Context.create(entity, env: entity_env) }
          .each { |context| execute_context(context, entity) }
      end

      private

      attr_reader :entity

      def execute_context(context, entity)
        filename = PrepareFilesystem.call(entity, context)

        StoreEntity.call(filename, entity, context)
      end
    end
  end
end
