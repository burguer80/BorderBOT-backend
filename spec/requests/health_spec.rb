require 'rails_helper'

RSpec.describe 'Health endpoint', type: :request do

  describe 'GET root index' do
    before { get '/health' }

    it 'should return I am A Teapot status with the code 418 ' do
      expect(response).to have_http_status(418)
    end
  end
end