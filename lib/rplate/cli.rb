# frozen_string_literal: true

module RPlate
  #
  # CLI is the container for the gem commands
  class CLI < Thor
    desc 'generate [ENTITIES]', 'generate a ruby class with the given name'
    option :type, aliases: '-t', default: 'class', type: :string, desc: '`class` or `module`'

    option :required_methods,
           aliases: '-m',
           default: [],
           type: :array,
           desc: "example: `-m self.perform 'self.valid?' initialize`"

    option :root, aliases: '-r', default: 'lib', type: :string, desc: 'example `-r app/controllers`'

    option :spec_root, aliases: '-s', default: 'spec/lib', type: :string,
                       desc: 'example `-s spec/controllers`'

    option :inflections,
           aliases: '-i',
           type: :array,
           default: [],
           desc: 'example: -i rplate:RPlate api:API'

    def generate(*entities)
      Commands::Generate.call(entities, options)
    end

    desc 'version', 'return the current version of rplate'
    def version
      puts VERSION
    end

    def self.exit_on_failure?
      true
    end
  end
end
