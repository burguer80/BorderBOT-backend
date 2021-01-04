require 'rails_helper'

RSpec.describe Ports::FindByPortNumber do
  let!(:expected_port_number) { '250301' }
  let!(:find_by_port_number_service) { described_class.new(expected_port_number) }

  describe "#initialize" do
    it 'should set the proper @port_number value' do
      expect(find_by_port_number_service.instance_variable_get(:@port_number)).to eq(expected_port_number)
    end
  end

  describe "#call" do
    it 'should invoke find method' do
      expect(find_by_port_number_service).to receive(:find)

      find_by_port_number_service.call
    end
  end

  describe "#stored_port" do
    pending
  end

  describe "#find" do
    pending
  end
end