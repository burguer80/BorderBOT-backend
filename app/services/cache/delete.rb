class Cache::Delete
  def call(key_name)
    return false unless key_name.present?
    Rails.cache.delete(key_name.to_s)
  end
end