# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate do
  describe '.perform' do
    let(:entity_name) { 'MyClass' }
    let(:root) { 'spec/fixtures/out' }
    let(:options) { { root: root, name: entity_name, type: 'class', methods: [] } }

    let(:fixture_filename) { 'my_class.rb' }
    let(:expected_entity) { fixture(fixture_filename).read }

    let(:result_filename) { "out/#{fixture_filename}" }
    let(:result_entity) { fixture(result_filename).read }

    subject { described_class.call(entity_name, options) }

    it 'creates a class ruby file with the right name' do
      subject
      expect(result_entity).to eq(result_entity)
    end
  end
end
