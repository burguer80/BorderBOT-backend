require 'rails_helper'

RSpec.describe Cache::Write do
  let!(:cache) { Rails.cache }
  let!(:parsed_hash) { { some_key: 'some_value' } }
  let!(:json_hash) { parsed_hash.to_json }
  let!(:service) { described_class.new(:some_key) }
  let!(:key_name) { parsed_hash.keys.first.to_s }

  describe "#call" do
    context 'with invalid arguments' do
      it 'should return false if empty or nil hash are provided' do
        expect(service.call('')).to eq false
        expect(service.call(nil)).to eq false
      end

      it 'should return ArgumentError if not arguments are provided ' do
        expect { service.call }.to raise_error(ArgumentError)
      end
    end

    context 'with valid key_name' do
      it 'should invoke Rails.cache.write with proper args, default_expire_time and return true' do
        expect(cache).to receive(:write).once.with(key_name, json_hash).and_return(true)

        service.call(parsed_hash)
      end

      it 'should invoke Rails.cache.write with proper args, custom_expire_time and return true' do
        expect(cache).to receive(:write).once.with(key_name, json_hash).and_return(true)

        service.call(parsed_hash)
      end
    end
  end
end