# frozen_string_literal: true

RSpec.describe RPlate::Logger do
  describe '.info' do
    subject(:info) { described_class.info('One message') }

    it 'sends to the Logger' do
      expect(described_class.logger).to receive(:info).with("One message\n")
      info
    end
  end
end
