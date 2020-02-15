# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::StoreEntity::AskOverwrite do
  describe '.confirm?' do
    let(:filename) { 'not/existing/filename/path' }

    subject(:confirm?) { described_class.confirm?(filename) }

    before do
      allow(described_class).to receive(:confirm?).and_call_original
    end

    it { is_expected.to be_truthy }

    context 'when a filename exists and confirmition is given' do
      let(:filename) { 'spec/fixtures/my_class.rb' }

      it 'asks for confirmation' do
        expect(HighLine).to receive(:agree).and_return(true)
        expect(confirm?).to be_truthy
      end
    end

    context 'when a filename exists and confirmition is not given' do
      let(:filename) { 'spec/fixtures/my_class.rb' }

      it 'asks for confirmation' do
        expect(HighLine).to receive(:agree).and_return(false)
        expect(confirm?).to be_falsey
      end
    end
  end
end
