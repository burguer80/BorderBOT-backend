require 'rails_helper'

RSpec.describe Http do
  describe "#initialize" do
    it 'should set the proper value to @URI' do
      some_domain = 'https://domain.com/'
      expected_uri = URI(some_domain)
      http_service = described_class.new(some_domain)
      expect(http_service.instance_variable_get(:@uri)).to eq(expected_uri)
    end
  end
end