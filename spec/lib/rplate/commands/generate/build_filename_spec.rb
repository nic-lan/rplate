# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::BuildFilename do
  describe '.call' do
    let(:root) { 'lib' }
    let(:entity) { double(:entity, entity_names: entity_names, root: root) }
    let(:entity_names) { %w[my_class] }
    let(:env) { :default }

    subject { described_class.call(entity, env) }

    it { is_expected.to eq('lib/my_class.rb') }

    context 'when opts env is spec' do
      let(:env) { :spec }

      it { is_expected.to eq('spec/lib/my_class_spec.rb') }
    end

    context 'when the given root differs from default one' do
      let(:root) { 'app/controllers' }

      it { is_expected.to eq('app/controllers/my_class.rb') }

      context 'when opts env is spec' do
        let(:env) { :spec }

        it { is_expected.to eq('spec/app/controllers/my_class_spec.rb') }
      end
    end

    context 'when opts provides multiple entity_names' do
      let(:entity_names) { %w[whatever my_class] }

      it { is_expected.to eq('lib/whatever/my_class.rb') }

      context 'when opts env is spec' do
        let(:env) { :spec }

        it { is_expected.to eq('spec/lib/whatever/my_class_spec.rb') }
      end

      context 'when the given root differs from default one' do
        let(:root) { 'app/controllers' }

        it { is_expected.to eq('app/controllers/whatever/my_class.rb') }
      end

      context 'when the given root differs from default one and spec env' do
        let(:root) { 'app/controllers' }
        let(:env) { :spec }

        it { is_expected.to eq('spec/app/controllers/whatever/my_class_spec.rb') }
      end
    end
  end
end
