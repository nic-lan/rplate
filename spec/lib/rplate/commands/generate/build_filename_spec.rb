# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::BuildFilename do
  describe '.call' do
    let(:name) { 'MyClass' }
    let(:root) { 'lib' }
    let(:entity) do
      RPlate::Commands::Generate::Entity.new(
        name: name,
        methods: [],
        type: 'class',
        root: root
      )
    end

    let(:opts) { {} }

    subject { described_class.call(entity, opts) }

    it { is_expected.to eq('lib/my_class.rb') }

    context 'when the given name is scoped under another namespace' do
      let(:name) { 'Whatever::MyClass' }

      it { is_expected.to eq('lib/whatever/my_class.rb') }
    end

    context 'when the given root differs from default' do
      let(:root) { 'app/controllers' }

      it { is_expected.to eq('app/controllers/my_class.rb') }
    end

    context 'when a postfix is given' do
      let(:opts) { { env: :spec } }

      it { is_expected.to eq('spec/lib/my_class_spec.rb') }
    end
  end
end