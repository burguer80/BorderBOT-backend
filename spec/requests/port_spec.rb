require 'rails_helper'

RSpec.describe 'Ports', type: :request do

  describe 'GET root index' do
    before { get '/' }

    it 'should return OK' do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end