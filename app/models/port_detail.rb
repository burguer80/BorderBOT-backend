# frozen_string_literal: true

class PortDetail < ApplicationRecord
  validates :number, uniqueness: true

  def full_name
    full_name = details['name']
    if details['crossing_name'].present?
      full_name += ", #{details['crossing_name']}"
    end

    full_name
  end
end
