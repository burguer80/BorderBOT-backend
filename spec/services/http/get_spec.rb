require 'rails_helper'

RSpec.describe Http::Get do
  describe "#call" do
    let(:some_domain) { 'https://domain.com/' }
    let(:uri) { URI(some_domain) }
    let(:json_response) { { key_name: 'value' }.to_json }

    context "method invokations" do
      after(:example) do
        described_class.new(some_domain).call
      end

      it 'should invoke the Net::HTTP.get with proper URI arg' do
        allow(JSON).to receive(:parse)
        expect(Net::HTTP).to receive(:get).once.with(uri)
      end

      it 'should invoke the JSON.parse with proper args' do
        allow(Net::HTTP).to receive(:get).once.with(uri).and_return(json_response)
        expect(JSON).to receive(:parse).once.with(json_response)
      end

    end

    it 'should return proper JSON parsed response' do
      expected_parsed_response = JSON.parse(json_response)
      allow(Net::HTTP).to receive(:get).once.with(uri).and_return(json_response)
      expect(described_class.new(some_domain).call).to eq(expected_parsed_response)
    end
  end
end
