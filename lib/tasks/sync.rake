# frozen_string_literal: true

namespace :sync do
  desc "RefreshLatestWaitTimesCache latest PWT, transform and cache the data"
  task get_latest_pwt_perform_now: :environment do
    LatestPortWaitTimesJob.perform_now
  end
end
