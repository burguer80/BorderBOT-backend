module Cacheable
  def cached
    Cache::Read.new(collection_name).call
  end

  def collection_name
    :default
  end

  def fetch
    cached.presence || save_to_cache
  end

  def records
    []
  end

  def save_to_cache
    Cache::Write.new(collection_name).call(records)
    cached
  end

end