# frozen_string_literal: true
# TODO: remove all the implementation related with this end point

class BordersController < ApplicationController

  def index
    render json: BordersService.recents
  end
end
