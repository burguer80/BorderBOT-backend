class Cache::Write
  def call(key_name, object, expire_time = 1.day)
    return false unless key_name.present? && object.present?
    Rails.cache.write(key_name.to_s, object.to_json, expires_in: expire_time)
  end
end