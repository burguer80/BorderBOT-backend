require 'rails_helper'

RSpec.describe Ports::All do

  let(:ports_key_name) { :ports }
  let!(:ports_all_service) { described_class.new }

  describe "#call" do
    it 'should invoke the ports method' do
      expect(ports_all_service).to receive(:fetch_all_ports).once
      ports_all_service.call
    end
  end
end