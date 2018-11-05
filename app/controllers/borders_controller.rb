# frozen_string_literal: true

class BordersController < ApplicationController
  def pull_data
    Port.pull_data
    Port.updatePortDetails
    render status: 200
  end
end
