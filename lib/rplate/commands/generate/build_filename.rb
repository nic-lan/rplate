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
          def call(entity, env)
            filename = build_filename(entity.entity_names, env)

            prefix_path = env == :default ? entity.root : entity.spec_root

            File.join(prefix_path, filename)
          end

          private

          def build_filename(entity_names, env)
            postfix = '_spec' if env == :spec

            "#{entity_names.join('/')}#{postfix}.rb"
          end
        end
      end
    end
  end
end
