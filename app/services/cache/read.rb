class Cache::Read
  def call(key_name)
    return false unless key_name.present?
    object = Rails.cache.read(key_name.to_s)
    object.present? ? JSON.parse(object).with_indifferent_access : nil
  end
end

