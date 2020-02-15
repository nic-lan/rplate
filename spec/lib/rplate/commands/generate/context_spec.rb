# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::Context do
  describe '#templates' do
    let(:name) { :default }

    subject { described_class.new(name).templates }

    it { is_expected.to eq(described_class::TEMPLATES[:default]) }

    context 'when name is spec' do
      let(:name) { :spec }

      it { is_expected.to eq(described_class::TEMPLATES[:spec]) }
    end
  end

  describe '.new' do
    let(:name) { :not_exisisting }

    subject { described_class.new(name) }

    it 'raises' do
      expect { subject }.to raise_error(described_class::Error)
    end
  end
end
