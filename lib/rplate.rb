# frozen_string_literal: true

%w[
  thor
  active_support/core_ext/hash
  active_support/core_ext/string/inflections
  dry-validation
  highline
  zeitwerk
  ostruct
  tilt
  tilt/erb
  fileutils
  rubocop
].each { |lib| require lib }

loader = Zeitwerk::Loader.for_gem

loader.inflector.inflect(
  'cli' => 'CLI',
  'rplate' => 'RPlate'
)

loader.setup

# `Rplate` is the main gem namespace
module RPlate
  def self.gem_root_path
    File.expand_path(File.join(File.dirname(__dir__)))
  end
end
