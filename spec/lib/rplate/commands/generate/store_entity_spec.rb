# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::StoreEntity do
  describe '.call' do
    let(:filename) { 'my_entity_file_path' }
    let(:entity) { double(:entity) }
    let(:context) { double(:context) }

    subject(:store_entity) { described_class.call(filename, entity, context) }

    before do
      allow(described_class).to receive(:new) { double(:call, call: true) }
    end

    specify do
      expect(described_class::AskOverwrite).to receive(:confirm?)
        .with(filename)
        .and_return(true)

      expect(described_class).to receive(:new).with(filename, entity, context)

      store_entity
    end

    context 'when the override is rejected' do
      specify do
        expect(described_class::AskOverwrite).to receive(:confirm?)
          .with(filename)
          .and_return(false)

        expect(described_class).not_to receive(:new)

        store_entity
      end
    end
  end
end
