require 'rails_helper'

RSpec.describe Cache::Write do
  subject(:service) { described_class.new }

  context 'with valid key_name and hash' do
    it 'should return success' do
      expect(service.call('key_name', 'hash')).to eq true
    end
  end

  context 'with invalid arguments' do
    it 'should return false if empty key_name and hash are provided' do
      expect(service.call('', '')).to eq false
    end

    it 'should return ArgumentError if not arguments are provided ' do
      expect { service.call }.to raise_error(ArgumentError)
    end
  end
end