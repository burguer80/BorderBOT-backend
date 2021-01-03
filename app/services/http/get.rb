# frozen_string_literal: true
require 'net/http'
require 'json'

class Http::Get < Http
  def call
    response = Net::HTTP.get(@uri)
    JSON.parse(response)
  end
end
