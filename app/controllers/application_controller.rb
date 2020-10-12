class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render nothing: true, status: 404
  end
end
