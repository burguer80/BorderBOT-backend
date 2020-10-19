# frozen_string_literal: true

class CacheService
  class << self
    def read(key_name)
      raise "key_name argument is required" unless key_name.present?
      object = Rails.cache.read(key_name.to_s)
      object.present? ? JSON.parse(object) : nil
    end

    def write(key_name, object)
      raise "key_name and object argument is required" unless key_name.present? && object.present?
      delete(key_name)
      Rails.cache.write(key_name.to_s, object.to_json, expires_in: EXPIRE_TIME)
    end

    def delete(key_name)
      raise "key_name argument is required" unless key_name.present?
      Rails.cache.delete(key_name.to_s)
    end

    private

    EXPIRE_TIME = 1.day
  end
end
