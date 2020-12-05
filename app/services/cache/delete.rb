# frozen_string_literal: true

class Cache::Delete < Cache::Base
  def call
    return false unless @key_name.present?
    Rails.cache.delete(@key_name.to_s)
  end
end