# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate do
  describe '.perform' do
    let(:entity_name) { 'MyClass' }
    let(:root) { OUT_PATH }
    let(:required_methods) { [] }
    let(:type) { 'class' }
    let(:options) do
      {
        'root' => root,
        'name' => entity_name,
        'type' => type,
        'required_methods' => required_methods
      }
    end

    subject { described_class.call(entity_name, options) }

    shared_examples 'create the required ruby files' do
      let(:fixture_filename) { "#{entity_name.underscore}.rb" }
      let(:expected_entity) { fixture(fixture_filename).read }

      let(:result_filename) { "out/#{fixture_filename}" }
      let(:result_entity) { fixture(result_filename).read }

      let(:fixture_filename_spec) { "#{entity_name.underscore}_spec.rb" }
      let(:expected_entity_spec) { fixture(fixture_filename_spec).read }

      let(:result_filename_spec) { "out/#{fixture_filename_spec}" }
      let(:result_entity_spec) { fixture(result_filename_spec).read }

      it 'creates the entity ruby file' do
        subject
        expect(result_entity).to eq(expected_entity)
      end

      it 'creates the related spec file' do
        subject
        expect(result_entity_spec).to eq(expected_entity_spec)
      end
    end

    it_behaves_like 'create the required ruby files'

    context 'when the directories in the entity or root are not existing' do
      let(:entity_name) { 'MyModule::MyClass' }

      it_behaves_like 'create the required ruby files'
    end

    context 'when some methods and namespaces' do
      let(:entity_name) { 'MyClassWithMethods' }
      let(:required_methods) { ['initialize', 'self.perform'] }

      it_behaves_like 'create the required ruby files'
    end

    context 'when invalid options' do
      let(:type) { 'invalid' }

      it 'raises' do
        expect { subject }.to raise_error(described_class::Error)
      end
    end
  end
end
