class Images::FormatsController < ApplicationController
  SUPPORTED_FORMATS = ["jpeg", "jpg", "png", "gif", "tiff", "g3fax", "ief"]

  def show
    image = Image.find(params[:id])
    set_requested_format or return

    tmp_image = MiniMagick::Image
      .read(image.uploads.first.download)
      .format(@format)

    response = image.uploads.attach(
      io: File.open(tmp_image.path),
      filename: generate_filename(image),
      content_type: "image/#{@format}"
    )

    render json: { url: url_for(response.first) }
  end

  private

  def set_requested_format
    unless SUPPORTED_FORMATS.include?(params[:format])
      render json: { error: "Unsupported format" }, status: :bad_request and return
    end
    @format = params[:format]
    true
  end

  def generate_filename(image)
    File.basename(base_filename(image),'.*') + ".#{@format}"
  end

  def base_filename(image)
    image.uploads.first.blob.filename.to_s
  end
end
