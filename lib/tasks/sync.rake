# frozen_string_literal: true

namespace :sync do
  desc "Pull borders data from https://bwt.cbp.gov"
  task pull_data: :environment do
    PullDataJob.perform_later
  end

  desc "Push latest borders data to firebase"
  task push_data: :environment do
    PushDataJob.perform_later
  end
end
