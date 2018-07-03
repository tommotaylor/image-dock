RSpec.describe "GET /images/:id" do
  context "when image exists" do
    let!(:image) { create(:image) }
    it "should return the url of the image" do
      get image_path(image)

      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response["data"].keys).to eq(["id", "type", "attributes"])
      expect(json_response["data"]["id"]).to eq(image.id.to_s)
      expect(json_response["data"]["type"]).to eq("images")
      expect(json_response["data"]["attributes"]["urls"]).to be_an_instance_of(Array)
      expect(json_response["data"]["attributes"]["urls"].count).to eq(1)
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
