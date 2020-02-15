# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::BuildView::Inflections do
  describe '#map' do
    let(:inflections) { %w[rplate:RPlate] }
    let(:name) { 'rplate' }

    subject(:map) { described_class.new(inflections).map(name) }

    it { is_expected.to eq('RPlate') }

    context 'when more than one inflection is given' do
      before { inflections << 'api:API' }

      it 'map to the right by the right inflection' do
        expect(map).to eq('RPlate')
      end
    end

    context 'when empty inflection is given' do
      let(:inflections) { [] }

      it 'map to the right by the right inflection' do
        expect(map).to eq('Rplate')
      end
    end
  end
end
