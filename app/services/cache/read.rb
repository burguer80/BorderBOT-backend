# frozen_string_literal: true

class Cache::Read < Cache::Base
  def call
    return false unless @key_name.present?
    object.present? ? parsed_object : nil
  end

  private

  def object
    Rails.cache.read(@key_name.to_s)
  end

  def parsed_object
    JSON.parse(object).kind_of?(Array) ? JSON.parse(object) : JSON.parse(object).with_indifferent_access
  end
end
