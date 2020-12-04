require 'rails_helper'

RSpec.describe 'Health endpoint', type: :request do

  describe 'GET root index' do
    before { get '/health' }

    it 'should return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end