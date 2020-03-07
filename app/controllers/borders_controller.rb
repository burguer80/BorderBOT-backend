# frozen_string_literal: true

class BordersController < ApplicationController

  def index
    render json: BordersService.recents
  end
end
