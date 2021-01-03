# frozen_string_literal: true

class Cache::Delete < Cache::Base
  def call
    Rails.cache.delete(@key_name.to_s)
  end
end