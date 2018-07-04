RSpec.describe "GET /images/:id/formats/:format" do
  context "with correct format" do
    context "from JPG" do
      let!(:image) { create(:image, :jpg) }
      let(:formats) { Images::FormatsController::SUPPORTED_FORMATS }

      it "should return the url to the image in the new format" do
        formats.each do |format|
          get "/images/#{image.id}/formats/#{format}"

          expect(response.status).to eq(200)
          expect(response).to be_api_json_response
          json_response = JSON.parse(response.body)
          expect(json_response["url"].split(".").last).to eq(format)
        end
      end
    end

    context "from PNG" do
      let!(:image) { create(:image, :png) }
      let(:formats) { Images::FormatsController::SUPPORTED_FORMATS }

      it "should return the url to the image in the new format" do
        formats.each do |format|
          get "/images/#{image.id}/formats/#{format}"

          expect(response.status).to eq(200)
          expect(response).to be_api_json_response
          json_response = JSON.parse(response.body)
          expect(json_response["url"].split(".").last).to eq(format)
        end
      end
    end
  end

  context "with incorrect format" do
    let!(:image) { create(:image, :jpg) }

    it "should return an error message" do
      get "/images/#{image.id}/formats/unknown"

      expect(response.status).to eq(400)
      expect(response).to be_api_json_response
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Unsupported format")
    end
  end
end
