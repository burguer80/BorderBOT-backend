# frozen_string_literal: true

namespace :ports do
  desc "RefreshLatestWaitTimesCache latest PWT, transform and cache the data"
  task refresh_latest_wait_times_cache: :environment do
    RefreshLatestWaitTimesCache.perform_now
  end
end
