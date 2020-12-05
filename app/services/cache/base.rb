# frozen_string_literal: true

class Cache::Base
  def initialize(key_name)
    @key_name = key_name
  end
end
