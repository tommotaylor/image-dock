class SerializableImage < JSONAPI::Serializable::Resource
  type "images"

  attribute :urls do
    @object.uploads.each.map do |upload|
      Rails.application.routes.url_helpers.url_for(upload)
    end
  end
end
