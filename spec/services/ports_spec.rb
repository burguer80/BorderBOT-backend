require 'rails_helper'

RSpec.describe Ports do
  describe "#prefixed_port_number" do
    let!(:ports_service) { described_class.new }

    it 'should the string prefixed properly' do
      port_number = 1
      expected_prefixed_port_number = "latest_pwt_#{port_number}"
      prefixed_port_number = ports_service.prefixed_port_number(port_number)

      expect(prefixed_port_number).to eq(expected_prefixed_port_number)
    end
  end
end