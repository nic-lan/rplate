# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      class BuildView
        # The Namespace class is responsible for handling the Namespace infos
        MODULE = 'module'
        CLASS = 'class'
        TYPE_REGEX = '(?<type>class|module)'
        Namespace = Struct.new(:name, :entity_constants, :root_dir) do
          # `type` tries to guess the type for the given namespace based on:
          # => its name
          # => the existence or not of the relative file
          #
          # @example When the namespace file is not present
          # => it is the default case and `module` is returned
          #
          # @example When the namespace file is present
          # => `module` or `class` is returned.
          #     Based on the fact that the namespace it is defined as `module` or `class`
          #
          # @example When the namespace file is present and it is a Struct
          # => `class` is returned because Struct is a class
          def type
            return MODULE if namespace_filename.nil?

            namespace_type_match = match_namespace_type(namespace_filename)

            # This is the case when the namespace is a Struct
            return CLASS if namespace_type_match.nil?

            namespace_type_match[:type] == MODULE ? MODULE : CLASS
          end

          private

          def namespace_filename
            Dir["#{File.expand_path(root_dir)}/**/#{name.underscore}.rb"].first
          end

          def match_namespace_type(namespace_filename)
            namespace_content = File.open(namespace_filename, 'r').read

            /#{TYPE_REGEX} #{name}/.match(namespace_content)
          end
        end
      end
    end
  end
end
