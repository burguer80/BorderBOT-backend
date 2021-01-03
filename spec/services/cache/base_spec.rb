require 'rails_helper'

RSpec.describe Cache::Base do

  context 'with valid key_name' do
    it 'should return proper key_name' do
      expected_key_name = 'some_key_name'
      service = described_class.new(expected_key_name)
      expect(service.key_name).to eq('some_key_name')
    end
  end

  context 'with key_name not present' do
    it 'should return false is nil is passed as arg' do
      service = described_class.new(nil)
      expect(service.key_name).to be_falsey
    end

    it 'should return false is empty string is passed as arg' do
      service = described_class.new('')
      expect(service.key_name).to be_falsey
    end
  end

end