# TODO: remove unnecessary code

namespace :borders do
  desc 'Pulls data from the offical website'
  task pull_data: :environment do
    Port.pull_data
    Port.updatePortDetails
  end
end
