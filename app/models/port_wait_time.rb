class PortWaitTime < ApplicationRecord
  validates :date, presence: true
  validates :port_number, presence: true
  validates :date, uniqueness: {scope: :port_number}
end
