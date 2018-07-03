class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: "#{object_name} not found" }, status: :not_found and return
  end

  private

  def object_name
    self.controller_name.singularize.capitalize
  end
end
