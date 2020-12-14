require 'rails_helper'
# TODO: Add pending expectations

RSpec.describe "LatestWaitTimes", type: :request do
  describe 'SHOW LatestWaitTimes' do
    it 'should return latest_wait_times from a given port number' do
      get latest_wait_time_path(260403)
      p response.parsed_body
    end
  end
end
