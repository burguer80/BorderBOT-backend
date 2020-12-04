require 'rails_helper'

RSpec.describe Cache::Read do
  let(:cache) { Rails.cache }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  subject(:service) { described_class.new }
  subject(:cache_write_service) { Cache::Write.new }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  context 'with valid key name' do
    it 'should return the expected cached hash if is exists' do
      expected_hash = { some_key: 'some_value' }

      cache_write_service.call(:some_key, expected_hash)
      some_hash = service.call(:some_key)
      expect(some_hash[:some_key]).to eq expected_hash[:some_key]
    end
  end

  context 'with invalid key name' do
    it 'should return false if no key name is empty' do
      some_hash = service.call('')
      expect(some_hash).to eq false
    end
  end
end