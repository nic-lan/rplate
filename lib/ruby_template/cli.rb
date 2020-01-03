# frozen_string_literal: true

module RubyTemplate
  #
  # CLI is the container for the gem commands
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    desc 'generate CLASS_NAME', 'generate a ruby class with the given name'
    option :type, aliases: '-t', default: 'class', type: :string
    option :methods, aliases: '-m', default: [], type: :array
    option :root, aliases: '-r', default: 'lib', type: :string
    def generate(entity_name)
      Commands::Generate.call(entity_name, options)
    end

    def self.exit_on_failure?
      puts 'failure'
      true
    end
  end
end

# ruby_template build Whatever -t class -m self.perform perform