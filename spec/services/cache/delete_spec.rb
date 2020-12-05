require 'rails_helper'

RSpec.describe Cache::Delete do
  let(:cache) { Rails.cache }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  context 'with valid key name' do
    subject(:service) { described_class.new(:some_key) }

    it 'should return true if key name provided exists and is deleted properly' do
      expected_hash = { some_key: 'some_value' }
      cache.write('some_key', expected_hash)

      expect(service.call).to eq true
    end


    it 'should return false if key name provided does not exists' do
      expect(service.call).to eq false
    end
  end

  context 'with invalid key name' do
    subject(:service) { described_class.new('') }

    it 'should return false if no key name is empty' do
      expect(service.call).to eq false
    end
  end
end