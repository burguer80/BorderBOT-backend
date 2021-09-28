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

  describe "#valid" do
    it 'should return true if port number is valid' do
      valid_port_number = all_port_numbers.sample
      expect(number_valid_service.send(:valid?, valid_port_number)).to be_truthy
    end

    it 'should return false if port number is not valid' do
      invalid_port_number = '000000'
      expect(number_valid_service.send(:valid?, invalid_port_number)).to be_falsey
    end
  end
end