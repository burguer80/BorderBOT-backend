require 'rails_helper'

RSpec.describe Ports::FindByPortNumber do
  let!(:port_number) { '250301' }
  let!(:find_by_port_number_service) { described_class.new(port_number) }

  describe "#initialize" do
    it 'should set the proper @port_number value' do
      expect(find_by_port_number_service.instance_variable_get(:@port_number)).to eq(port_number)
    end
  end

  describe "#call" do
    it 'should invoke find method' do
      expect(find_by_port_number_service).to receive(:find)

      find_by_port_number_service.call
    end
  end

  describe "#find" do
    after(:example) { find_by_port_number_service.send(:find) }

    it 'should invoke stored_port and not invoke Ports::RefreshLatestWaitTimesCache.new if stored_port is exists' do
      allow(find_by_port_number_service).to receive(:stored_port).once.and_return(true)
      expect(Ports::RefreshLatestWaitTimesCache).not_to receive(:new)
      expect(find_by_port_number_service).to receive(:stored_port).once
    end

    it 'should invoke invoke Ports::RefreshLatestWaitTimesCache.new.call and not stored_port if stored_port does not exists' do
      ports_refresh_cache_service = Ports::RefreshLatestWaitTimesCache.new
      allow(Ports::RefreshLatestWaitTimesCache).to receive(:new).once.and_return(ports_refresh_cache_service)
      allow(find_by_port_number_service).to receive(:stored_port).and_return(nil)
      expect(ports_refresh_cache_service).to receive(:call).once
    end
  end

  describe "#stored_port" do
    it 'should invoke Cache::Read.new and call methods with proper args' do
      prefixed_port_number = "latest_pwt_#{port_number}"
      cache_read_service = Cache::Read.new(prefixed_port_number)
      allow(Cache::Read).to receive(:new).once.with(prefixed_port_number).and_return(cache_read_service)
      expect(cache_read_service).to receive(:call).once

      find_by_port_number_service.send(:stored_port)
    end
  end
end