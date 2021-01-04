require 'rails_helper'

RSpec.describe Cache::Read do
  let!(:cache) { Rails.cache }
  let!(:parsed_hash) { { some_key: 'some_value' } }
  let!(:json_hash) { parsed_hash.to_json }
  let!(:key_name) { parsed_hash.keys.first.to_s }
  let!(:cache_delete_service) { described_class.new(key_name) }

  before(:example) do
    cache.clear
  end

  describe "#call" do
    before(:example) do
      allow(cache_delete_service).to receive(:parsed_object).and_return(parsed_hash)
    end

    it 'should return parsed object if object is present' do
      allow(cache_delete_service).to receive(:object).and_return(json_hash)

      expect(cache_delete_service.call).to eq(parsed_hash)
    end

    it 'should return nil object if object is not present' do
      allow(cache_delete_service).to receive(:object).and_return(nil)

      expect(cache_delete_service.call).to be_falsey
    end
  end

  describe "#object" do
    it 'should invoke Rails.cache.read with proper args' do
      allow(cache).to receive(:read).once.with(key_name).and_return(parsed_hash)

      expect(cache_delete_service.send(:object)).to be_truthy
    end
  end

  describe "#parsed_object" do
    let(:parsed_array) { %w[260101 260301] }
    let(:json_array) { parsed_array.to_json }

    context "JSON invokes" do
      after(:example) do
        cache_delete_service.send(:parsed_object)
      end

      it 'should invoke JSON.parse twice and return the parsed hash with_indifferent_access' do
        allow(cache_delete_service).to receive(:object).twice.and_return(json_hash)
        expect(JSON).to receive(:parse).twice.with(json_hash).and_return(parsed_hash)
      end

      it 'should invoke JSON.parse twice and return the parsed array object' do
        allow(cache_delete_service).to receive(:object).twice.and_return(json_array)
        expect(JSON).to receive(:parse).twice.with(json_array).and_return(parsed_array)
      end
    end

    it 'should return the proper parsed hash with_indifferent_access' do
      allow(cache_delete_service).to receive(:object).twice.and_return(json_hash)

      expect(cache_delete_service.send(:parsed_object)).to eq(parsed_hash.with_indifferent_access)
    end

    it 'should return the proper parsed array' do
      allow(cache_delete_service).to receive(:object).twice.and_return(json_array)

      expect(cache_delete_service.send(:parsed_object)).to eq(parsed_array)
    end

  end
end