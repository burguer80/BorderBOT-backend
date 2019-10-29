# frozen_string_literal: true

class HistoricalWaitTime < ApplicationRecord
  validates :port_number, presence: true
  validates :month_number, presence: true
  validates_uniqueness_of :port_number, scope: [:month_number, :time_slot, :bwt_day]
end
