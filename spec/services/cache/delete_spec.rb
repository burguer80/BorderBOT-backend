require 'rails_helper'

RSpec.describe Cache::Delete do
  describe "#call" do
    let!(:cache) { Rails.cache }

    it 'should invoke Rails.cache.delete with proper arg' do
      expected_hash = { some_key: 'some_value' }
      key_name = expected_hash.keys.first.to_s
      allow(cache).to receive(:delete).once.with(key_name).and_return(true)
      cache.write('some_key', expected_hash)

      expect(described_class.new('some_key').call).to be_truthy
    end

  end
end
