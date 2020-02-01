# frozen_string_literal: true

module RPlate
  #
  # CLI is the container for the gem commands
  class CLI < Thor
    desc 'generate CLASS_NAME', 'generate a ruby class with the given name'
    option :type, aliases: '-t', default: 'class', type: :string, desc: '`class` or `module`'
    option :required_methods, aliases: '-m', default: [], type: :array, desc: 'the class methods'
    option :root, aliases: '-r', default: 'lib', type: :string, desc: 'example: `app/controllers`'
    def generate(entity_name)
      Commands::Generate.call(entity_name, options)
    end

    desc 'version', 'return the current version of rplate'
    def version
      puts VERSION
    end

    def self.exit_on_failure?
      puts 'failure'
      true
    end
  end
end
