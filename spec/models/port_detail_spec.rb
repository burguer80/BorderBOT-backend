require 'rails_helper'

RSpec.describe PortDetail, type: :model do
  it { is_expected.to have_db_column(:number) }
  it { is_expected.to have_db_column(:details) }

  describe '#validations' do
    it 'should validates uniqueness of taken_at column' do
      should validate_uniqueness_of(:number)
    end
  end

  describe '#save' do
    let(:port_detail) { build(:port_detail) }

    it 'is persisted' do
      expect(port_detail.save).to eq true
      expect(PortDetail.count).to eq 1
    end
  end
end
