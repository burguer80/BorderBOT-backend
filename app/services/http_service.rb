# frozen_string_literal: true
require 'net/http'
require 'json'

class HttpService
  def initialize(url)
    @uri = URI(url)
  end

  def get_json
    response = Net::HTTP.get(@uri)
    JSON.parse(response)
  end
end
