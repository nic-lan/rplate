# frozen_string_literal: true

module RPlate
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
        class << self
          #
          # @param entity_name [Object] The entity we want to generate the filename from
          # @return [String] The built filename
          def call(entity, opts = {})
            filename = build_filename(opts)
            prefix_path = 'spec' if opts[:env] == :spec

            [prefix_path, entity.root, filename].compact.join('/')
          end

          private

          def build_filename(opts)
            postfix = '_spec' if opts[:env] == :spec

            "#{opts[:entity_constants].map(&:underscore).join('/')}#{postfix}.rb"
          end
        end
      end
    end
  end
end
