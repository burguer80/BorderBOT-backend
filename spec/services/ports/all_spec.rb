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

  describe "#stored_ports" do
    it 'should Cache::Read call method with proper args' do
      cache_read_service = Cache::Read.new(ports_key_name)
      allow(Cache::Read).to receive(:new).with(ports_key_name).and_return(cache_read_service)
      expect(cache_read_service).to receive(:call).once
      ports_all_service.send(:stored_ports)
    end
  end

  describe "#save_ports" do
    let!(:cache_write_service) { Cache::Write.new(ports_key_name) }

    before(:example) do
      allow(ports_all_service).to receive(:stored_ports).once
      allow(Cache::Write).to receive(:new).with(ports_key_name).and_return(cache_write_service)
    end

    after(:example) do
      ports_all_service.send(:save_ports)
    end

    it 'should Cache::Write call method with proper args' do
      allow(ports_all_service).to receive(:formatted_ports).once
      expect(cache_write_service).to receive(:call).once
    end

    it 'should Cache::Write call method with proper args' do
      allow(cache_write_service).to receive(:call).once
      expect(ports_all_service).to receive(:formatted_ports).once
    end
  end

  describe "#ports" do
    after(:example) do
      ports_all_service.send(:ports)
    end

    it 'should invoke stored_ports if is not nil' do
      allow(ports_all_service).to receive(:stored_ports).once.and_return(true)
      expect(ports_all_service).to receive(:stored_ports).once
      expect(ports_all_service).not_to receive(:save_ports)
    end

    it 'should invoke save_ports if stored_ports is nil' do
      allow(ports_all_service).to receive(:stored_ports).once.and_return(nil)
      expect(ports_all_service).to receive(:save_ports).once
    end
  end

  describe "#formatted_ports" do
    let!(:port_details_list) do
      build_list(:port_detail, 10)
    end

    it 'should return the proper formatted_ports' do
      expected_formatted_ports = port_details_list.map { |port|
        { id: port.number,
          details: port.details,
          time_zone: port.time_zone,
          created_at: port.created_at,
          updated_at: port.updated_at }
      }
      allow(PortDetail).to receive(:all).once.and_return(port_details_list)
      formatted_ports = ports_all_service.send(:formatted_ports)
      expect(formatted_ports).to eq(expected_formatted_ports)
    end
  end

end