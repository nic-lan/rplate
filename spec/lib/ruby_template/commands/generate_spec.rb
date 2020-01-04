# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate do
  describe '.perform' do
    let(:entity_name) { 'MyClass' }
    let(:root) { 'spec/fixtures/out' }
    let(:require_methods) { [] }
    let(:options) do
      {
        root: root,
        name: entity_name,
        type: 'class',
        require_methods: require_methods
      }
    end

    let(:fixture_filename) { 'my_class.rb' }
    let(:expected_entity) { fixture(fixture_filename).read }

    let(:result_filename) { "out/#{fixture_filename}" }
    let(:result_entity) { fixture(result_filename).read }

    subject { described_class.call(entity_name, options) }

    shared_examples 'creates a class ruby file with the right name' do
      it 'creates a class ruby file with the right name' do
        subject
        expect(result_entity).to eq(result_entity)
      end
    end

    it_behaves_like 'creates a class ruby file with the right name'

    context 'when the directories in the entity or root are not existing' do
      let(:entity_name) { 'Whatever::MyModule::MyClass' }
      let(:not_xisting_dir) { "#{root}/whatever" }

      before do
        FileUtils.rm_rf(not_xisting_dir)
      end

      after do
        FileUtils.rm_rf(not_xisting_dir)
      end

      it_behaves_like 'creates a class ruby file with the right name'
    end

    context 'when some methods and namespaces' do
      let(:entity_name) { 'Whatever::MyClass' }
      let(:fixture_filename) { 'my_namespaced_class_with_methods.rb' }
      let(:result_filename) { 'out/whatever/my_class.rb' }
      let(:require_methods) { ['initialize', 'perform'] }

      it_behaves_like 'creates a class ruby file with the right name'
    end
  end
end
