require 'rails_helper'

RSpec.describe Ports::All do

  let(:ports_key_name) { :ports }
  let!(:ports_all_service) { described_class.new }

  describe "#call" do
    it 'should invoke the ports method' do
      expect(ports_all_service).to receive(:ports).once
      ports_all_service.call
    end
  end

  describe "#ports" do
    let!(:port_details_list) do
      build_list(:port_detail, 10)
    end

    it 'should return the proper ports' do
      expected_formatted_ports = port_details_list.map { |port|
        { id: port.number,
          details: port.details,
          time_zone: port.time_zone,
          created_at: port.created_at,
          updated_at: port.updated_at }
      }
      allow(PortDetail).to receive(:all).once.and_return(port_details_list)
      formatted_ports = ports_all_service.send(:ports)
      expect(formatted_ports).to eq(expected_formatted_ports)
    end
  end
end