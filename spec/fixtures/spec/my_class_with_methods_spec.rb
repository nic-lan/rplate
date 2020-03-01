# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MyClassWithMethods do
  describe '.perform' do
    subject(:perform) { described_class.perform }
  end
end
