# TODO: remove all the implementation related with this end point

# frozen_string_literal: true

class BordersController < ApplicationController

  def index
    render json: BordersService.recents
  end
end
