# frozen_string_literal: true

namespace :sync do
  desc "Pull borders data from https://bwt.cbp.gov"
  task pull_data: :environment do
    sd = SyncDataService.new
    sd.pull_data
  end

  desc "Push latest borders data to firebase"
  task push_data: :environment do
    sd = SyncDataService.new
    sd.push_to_firebase
  end
end
