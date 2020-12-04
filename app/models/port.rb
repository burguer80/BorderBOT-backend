# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Port < ApplicationRecord
  validates :taken_at, presence: true
  validates :number, presence: true
  validates :taken_at, uniqueness: { scope: :number }
end