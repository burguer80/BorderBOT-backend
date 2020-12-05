require 'rails_helper'

RSpec.describe Cache::Read do
  let(:cache) { Rails.cache }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  subject(:cache_write_service) { Cache::Write.new(:some_key) }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  context 'with valid key name' do
    subject(:service) { described_class.new(:some_key) }

    it 'should return the expected cached hash if is exists' do
      expected_hash = { some_key: 'some_value' }

      cache_write_service.call(expected_hash)
      stored_hash = service.call
      expect(stored_hash[:some_key]).to eq expected_hash[:some_key]
    end
  end

  context 'with invalid key name' do
    subject(:service) { described_class.new('') }

    it 'should return false if no key name is empty' do
      expect(service.call).to eq false
    end
  end
end