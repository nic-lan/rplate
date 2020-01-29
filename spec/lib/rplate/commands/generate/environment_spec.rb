# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::Environment do
  describe '#templates' do
    let(:env) { :default }

    subject { described_class.new(env).templates }

    it { is_expected.to eq(described_class::TEMPLATES[:default]) }

    context 'when env is spec' do
      let(:env) { :spec }

      it { is_expected.to eq(described_class::TEMPLATES[:spec]) }
    end
  end

  describe '.new' do
    let(:env) { :not_exisisting }

    subject { described_class.new(env) }

    it 'raises' do
      expect { subject }.to raise_error(described_class::Error)
    end
  end
end
