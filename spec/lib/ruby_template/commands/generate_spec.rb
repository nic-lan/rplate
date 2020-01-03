# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate do
  describe '.perform' do
    let(:entity_name) { 'MyClass' }
    let(:options) { { root: 'lib', name: entity_name, type: 'class', methods: [] } }

    subject { described_class.call(entity_name, options) }

    it 'creates a class ruby file with the right name' do
      subject
    end
  end
end
