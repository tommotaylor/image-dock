RSpec.describe "GET /images/:id" do
  context "when image exists" do
    it "should return the url of the image" do
    end
  end

  context "when image does not exist" do
    it "should return not found" do
      get image_path(1)

      expect(response.status).to eq(404)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Image not found")
    end
  end
end
