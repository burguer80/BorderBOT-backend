require 'rails_helper'

RSpec.describe Ports::NumberValid do
  let!(:number_valid_service) { described_class.new }
  let!(:port_number) { '250301' }
  let!(:port_detail_list) { build_list(:port_detail, 10) }
  let!(:all_port_numbers) { port_detail_list.pluck(:number) }
  let!(:valid_ports_ids_cache_key_name) { :valid_ports_ids }

  describe "#call" do
    it 'should invoke valid? methid with proper args' do
      expect(number_valid_service).to receive(:valid?).once.with(port_number)

      number_valid_service.call(port_number)
    end

    it 'should return true if port number is valid' do
      allow(number_valid_service).to receive(:valid?).once.and_return(true)

      expect(number_valid_service.call(port_number)).to be_truthy
    end

    it 'should return false if port number is not valid' do
      allow(number_valid_service).to receive(:valid?).once.and_return(false)

      expect(number_valid_service.call(port_number)).to be_falsey
    end
  end

  describe "#port_numbers" do
    it 'should invoke stored_port_numbers and not invoke save_port_numbers_to_cache if stored_port_numbers exists' do
      allow(number_valid_service).to receive(:stored_port_numbers).once.and_return(true)
      expect(number_valid_service).to receive(:stored_port_numbers).once
      expect(number_valid_service).not_to receive(:save_port_numbers_to_cache)

      number_valid_service.send(:port_numbers)
    end

    it 'should invoke save_port_numbers_to_cache if stored_port_numbers does not exists' do
      allow(number_valid_service).to receive(:stored_port_numbers).once.and_return(false)
      expect(number_valid_service).to receive(:stored_port_numbers).once
      expect(number_valid_service).to receive(:save_port_numbers_to_cache).once

      number_valid_service.send(:port_numbers)
    end
  end

  describe "#stored_port_numbers" do

    it 'should invoke save_port_numbers_to_cache if stored_port_numbers does not exists' do
      cache_read_service = Cache::Read.new(valid_ports_ids_cache_key_name)
      allow(Cache::Read).to receive(:new).once.with(valid_ports_ids_cache_key_name).and_return(cache_read_service)
      expect(cache_read_service).to receive(:call).once

      number_valid_service.send(:stored_port_numbers)
    end
  end

  describe "#save_port_numbers_to_cache" do
    before(:example) { allow(PortDetail).to receive(:all).once.and_return(port_detail_list) }

    after(:example) { number_valid_service.send(:save_port_numbers_to_cache) }

    it 'should invoke PortDetail.all.pluck with proper args' do
      expect(port_detail_list).to receive(:pluck).with(:number)
    end

    it 'should invoke Cache::Write.new.call with proper args' do
      cache_write_service = Cache::Write.new(valid_ports_ids_cache_key_name)
      allow(Cache::Write).to receive(:new).once.with(valid_ports_ids_cache_key_name).and_return(cache_write_service)
      expect(cache_write_service).to receive(:call).once.with(all_port_numbers)
    end

    it 'should invoke stored_port_numbers' do
      expect(number_valid_service).to receive(:stored_port_numbers)
    end
  end

  describe "#valid" do
    it 'should return true if port number is valid' do
      valid_port_number = all_port_numbers.sample
      allow(number_valid_service).to receive(:port_numbers).once.and_return(all_port_numbers)
      expect(number_valid_service.send(:valid?, valid_port_number)).to be_truthy
    end

    it 'should return false if port number is not valid' do
      invalid_port_number = '000000'
      allow(number_valid_service).to receive(:port_numbers).once.and_return(all_port_numbers)
      expect(number_valid_service.send(:valid?, invalid_port_number)).to be_falsey
    end
  end
end