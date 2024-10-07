# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate do
  describe '.perform' do
    let(:entity_name) { %w[my_class] }
    let(:root) { OUT_PATH }
    let(:required_methods) { [] }
    let(:inflections) { [] }
    let(:type) { 'class' }
    let(:options) do
      {
        'root' => root,
        'name' => entity_name,
        'type' => type,
        'required_methods' => required_methods,
        'inflections' => inflections
      }
    end

    subject { described_class.call(entity_name, options) }

    shared_examples 'create the required ruby files' do
      let(:base_filename) { entity_name.join('/') }
      let(:fixture_filename) { "#{base_filename}.rb" }
      let(:expected_entity) { fixture(fixture_filename) }

      let(:result_filename) { "out/#{fixture_filename}" }
      let(:result_entity) { fixture(result_filename, prefix_path: false) }

      let(:fixture_filename_spec) { "spec/#{base_filename}_spec.rb" }
      let(:expected_entity_spec) { fixture(fixture_filename_spec) }

      let(:result_filename_spec) { "spec/#{root}/#{base_filename}_spec.rb" }
      let(:result_entity_spec) do
        fixture(result_filename_spec,
                prefix_path: false)
      end

      before { subject }

      it 'creates the entity ruby file' do
        expect(result_entity).to eq(expected_entity)
      end

      it 'creates the related spec file' do
        expect(result_entity_spec).to eq(expected_entity_spec)
      end
    end

    it_behaves_like 'create the required ruby files'

    context 'when the given entity has a namespaced class name by ::' do
      let(:entity_name) { %w[my_module my_class] }

      it_behaves_like 'create the required ruby files'
    end

    context 'when some methods and namespaces' do
      let(:entity_name) { %w[my_class_with_methods] }
      let(:required_methods) { ['initialize', 'self.perform'] }

      it_behaves_like 'create the required ruby files'
    end

    context 'when one inflection is provided' do
      let(:entity_name) { %w[rplate] }
      let(:inflections) { %w[rplate:RPlate] }

      it_behaves_like 'create the required ruby files'
    end

    context 'when invalid options' do
      let(:type) { 'invalid' }

      it 'raises' do
        expect(RPlate::Logger).to receive(:info).with({ type: ['must be one of: class, module'] })
        expect(described_class).not_to receive(:new)

        subject
      end
    end
  end
end
