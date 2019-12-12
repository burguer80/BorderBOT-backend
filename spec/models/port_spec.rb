require 'rails_helper'

RSpec.describe Port, type: :model do
  describe 'Validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:taken_at)
      should validate_presence_of(:number)
    end

    it 'should validates uniqueness of taken_at column' do
      should validate_uniqueness_of(:taken_at).scoped_to(:number)
    end
  end
end