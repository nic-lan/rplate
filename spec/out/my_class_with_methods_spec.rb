# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MyClassWithMethods do
  describe '#initialize' do
    subject(:initialize) { described_class.new.initialize }
  end

  describe '.perform' do
    subject(:perform) { described_class.perform }
  end
end
