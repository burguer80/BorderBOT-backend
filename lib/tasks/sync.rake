# frozen_string_literal: true

namespace :sync do
  desc "Pull and Push latest borders data to firebase"
  task all: :environment do
    p Time.now
    # PullDataJob.perform_now
    pull_bwt_data_now
    PushDataJob.perform_now
    p Time.now
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

    btw = BtwApiService.new
    threads = []
    threads << Thread.new {
      PullDataJob.perform_now
    }
    PortDetail.pluck(:number).each { |port_number|
      threads << Thread.new {
        BwtJob.perform_now(port_number)
        btw.get_port_btw(port_number, today)
      }
    }
    threads.each { |thr| thr.join }
  end

  def today
    Date.today.strftime("%Y-%m-%d")
  end
end
