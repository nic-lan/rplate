# frozen_string_literal: true

module RPlate
  module Commands
    class Generate
      class BuildView
        Method = Struct.new(:method_name, :method_subject_name, :method_in_subject_block) do
          CLASS_METHOD_REGEX = /\Aself\.\w+\z/.freeze
          INITIALIZE_METHOD_REGEX = /\Ainitialize\z/.freeze

          class << self
            def build(name, env)
              return if env == :spec && INITIALIZE_METHOD_REGEX.match?(name)
              return new(name, name, name) if env == :default

              new(*init_args(name))
            end

            private

            def init_args(name)
              return args_for_class_method(name) if CLASS_METHOD_REGEX.match?(name)

              args_for_instance_method(name)
            end

            def args_for_instance_method(name)
              ["##{name}", name, "new.#{name}"]
            end

            def args_for_class_method(name)
              clean_method_name = name.gsub('self.', '')

              [".#{clean_method_name}", clean_method_name, clean_method_name]
            end
          end
        end
      end
    end
  end
end
