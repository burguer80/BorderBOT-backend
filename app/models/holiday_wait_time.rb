class HolidayWaitTime < ApplicationRecord
  validates :port_number, presence: true
  validates :holiday_date, presence: true
  validates_uniqueness_of :port_number, scope: [:port_number,
                                                :bwt_date,
                                                :time_slot,
                                                :holiday_date]
end
