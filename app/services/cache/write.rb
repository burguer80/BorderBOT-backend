# frozen_string_literal: true

class Cache::Write < Cache
  def call(object)
    return false unless object.present?
    Rails.cache.write(@key_name.to_s, object.to_json)
  end
end