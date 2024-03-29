class LatestWaitTimesController < ApplicationController
  before_action :valid_port, only: [:show]

  def index
    refresh_latest_wait_times_cache unless latest_wait_times

    render json: latest_wait_times_response
  end

  # TODO: remove show related logic since index now support filter param
  def show
    render_lwt_response
  end

  private

  def port
    Ports::FindByPortNumber.new(port_number_param).call
  end

  def port_ids_param
    params[:port_ids]&.split(',') || []
  end

  def port_number_param
    params[:id].to_s
  end

  def render_lwt_response
    render json: port
  end

  def valid_port
    render_404 unless Ports::NumberValid.new.call(port_number_param)
  end

  def latest_wait_times
    Cache::Read.new(:latest_wait_times).call
  end

  def latest_wait_times_response
    if port_ids_param.present?
      latest_wait_times.select { |port_details| port_ids_param.include? port_details['id'] }
    else
      latest_wait_times
    end
  end

  def refresh_latest_wait_times_cache
    Ports::RefreshLatestWaitTimesCache.new.call
  end
end
