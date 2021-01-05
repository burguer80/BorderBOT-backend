require 'rails_helper'

RSpec.describe Cache do

  context 'with valid key_name' do
    it 'should return proper key_name' do
      expected_key_name = 'some_key_name'
      service = described_class.new(expected_key_name)
      expect(service.key_name).to eq('some_key_name')
    end
  end
end