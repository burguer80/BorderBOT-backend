# frozen_string_literal: true

class Cache
  attr_reader :key_name

  def initialize(key_name)
    return false unless key_name.present?
    @key_name = key_name.to_s
  end
end
