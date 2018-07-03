class ImagesController < ApplicationController
  def create
    if request.content_type == "multipart/form-data"
      response = Image.create(parsed_params)
      render jsonapi: response
    elsif request.content_type ==  "application/json"
      render json: { error: "Unsupported request type, please use 'multipart/form-data'"},
        status: :bad_request
    end
  end

  def show
    image = Image.find(params[:id])
    render jsonapi: image
  end

  private

  def parsed_params
    image_params[:uploads].map {|upload| { uploads: [ upload ] }}
  end

  def image_params
    params.permit(:uploads => [])
  end
end
