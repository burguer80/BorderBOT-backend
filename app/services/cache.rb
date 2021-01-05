# frozen_string_literal: true

class Cache
  attr_reader :key_name

  def initialize(key_name)
    @key_name = key_name.to_s
  end
end
