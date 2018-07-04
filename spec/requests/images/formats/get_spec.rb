RSpec.describe "GET /images/:id/formats/:format" do
  context "with incorrect format" do
    let!(:image) { create(:image) }

    it "should return an error message" do
      get "/images/#{image.id}/formats/unknown"
      expect(response.status).to eq(400)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Unsupported format")
    end
  end
end
