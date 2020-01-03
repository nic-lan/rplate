# frozen_string_literal: true

module RubyTemplate
  module Commands
    #
    # Generate is the command class responsible to generate the ruby file
    class Generate
      class Entity < OpenStruct; end

      def self.call(entity_name, options)
        validation_result = Commands::Generate::Validator.validate(entity_name, options)
        return unless validation_result.success?

        new(validation_result.output).call
      end

      def initialize(entity)
        @entity = Entity.new(entity)
      end

      def call
        entity_view = build_entity_view
        filename = build_filename

        File.open(filename, 'w') { |f| f.write(entity_view) }
      end

      private

      attr_reader :entity

      def build_entity_view
        Tilt::ERBTemplate.new('templates/entity.rb.erb', trim: 0).render(entity)
      end

      def build_filename
        BuildFilename.call(entity)
      end
    end
  end
end
