class PortDetail < ApplicationRecord
  validates :number, uniqueness: true
end
