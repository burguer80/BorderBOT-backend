# frozen_string_literal: true

class Cache::Write < Cache
  def call(object, expire_time = 1.day)
    return false unless object.present?
    Rails.cache.write(@key_name.to_s, object.to_json, expires_in: expire_time)
  end
end