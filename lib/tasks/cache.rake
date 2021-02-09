# frozen_string_literal: true

namespace :cache do
  desc "Clear application cache"
  task clear_all: :environment do
    Rails.cache.clear
  end
end
