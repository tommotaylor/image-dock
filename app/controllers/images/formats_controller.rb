class Images::FormatsController < ApplicationController
  SUPPORTED_FORMATS = ["jpeg", "jpg", "png", "gif", "tiff", "g3fax", "ief"]

  def show
    set_requested_format or return
  end

  private

  def set_requested_format
    unless SUPPORTED_FORMATS.include?(params[:format])
      render json: { error: "Unsupported format" }, status: :bad_request and return
    end
    @requested_format = params[:format]
    true
  end
end
