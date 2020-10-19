# frozen_string_literal: true

namespace :sync do
  desc "Pull and Push latest borders data to firebase"
  task all: :environment do
    PullDataJob.perform_later
    pull_bwt_data
    PushDataJob.perform_later
  end

  desc "Pull and Push latest borders data to firebase with perform_now"
  task all_perform_now: :environment do
    PullDataJob.perform_now
    pull_bwt_data_now
    PushDataJob.perform_now
  end

  # TODO: leave just this rake task and remove all others with the related functionality
  desc "Get latest PWT, transform and cache the data"
  task get_latest_pwt_perform_now: :environment do
    LatestPortWaitTimesJob.perform_now
  end

  desc "Delete records older than 3 days"
  task delete_old_records: :environment do
    expiration_date = Date.today.beginning_of_day - 3.days
    Port.where("created_at <= ?", expiration_date).delete_all
    PortWaitTime.where("created_at <= ?", expiration_date).delete_all
  end

  desc "Pull borders data from https://bwt.cbp.gov"
  task pull_data: :environment do
    PullDataJob.perform_later
    pull_bwt_data
  end

  desc "Push latest borders data to firebase"
  task push_data: :environment do
    PushDataJob.perform_later
  end

  def pull_bwt_data
    PortDetail.pluck(:number).each { |pd|
      BwtJob.perform_later(pd)
    }
  end

  def pull_bwt_data_now
    PortDetail.pluck(:number).each { |port_number|
      BwtJob.perform_now(port_number)
    }
  end

  # def pull_bwt_data_now_multithreading
  #   btw = BtwApiService.new
  #   threads = []
  #   threads << Thread.new {
  #     PullDataJob.perform_now
  #   }
  #   PortDetail.pluck(:number).each { |port_number|
  #     threads << Thread.new {
  #       BwtJob.perform_now(port_number)
  #       btw.get_port_btw(port_number, today)
  #     }
  #   }
  #   threads.each { |thr| thr.join }
  # end

  def today
    Date.today.strftime("%Y-%m-%d")
  end
end
