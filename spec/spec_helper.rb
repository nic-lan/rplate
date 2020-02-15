# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'
require 'rplate'

FIXTURES_PATH = 'spec/fixtures'
OUT_PATH = 'out'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end

  config.before(:suite) do
    FileUtils.rm_rf(OUT_PATH)
    FileUtils.rm_rf("spec/#{OUT_PATH}")
  end

  config.before do
    allow(RPlate::Commands::Generate::StoreEntity::AskOverwrite).to receive(:confirm?)
      .and_return(true)
  end
end

def fixture(filename, prefix_path: true)
  prefix = FIXTURES_PATH if prefix_path == true
  file_path = [prefix, filename].compact.join('/')
  File.open(file_path).read
end

def without_empty_lines(string)
  string.gsub(/^\s*$\n/, '')
end
