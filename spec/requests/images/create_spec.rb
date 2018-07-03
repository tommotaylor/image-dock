RSpec.describe "POST /images" do
  context "with correct request type" do
    let(:headers){ { "CONTENT_TYPE" => "multipart/form-data" } }

    context "with a single image file" do
      it "should create the image with one upload" do
        file = fixture_file_upload('spec/fixtures/bill-murray.jpg', 'image/jpg')
        expect do
          post images_path, { params: { uploads: [file] }, headers: headers }
        end.to change { Image.count }.by 1

        expect(Image.first.uploads.count).to eq(1)
        expect(response.status).to eq(200)
        json_response = JSON.parse(response.body)
        expect(json_response["data"]).to be_an_instance_of(Array)
        expect(json_response["data"].first["attributes"]["urls"].count).to eq(1)
      end
    end

    context "with multiple image files" do
      it "should create two images with uploads" do
        file_1 = fixture_file_upload('spec/fixtures/bill-murray.jpg', 'image/jpg')
        file_2 = fixture_file_upload('spec/fixtures/bill-murray-2.jpg', 'image/jpg')
        expect do
          post images_path, { params: { uploads: [file_1, file_2] }, headers: headers }
        end.to change { Image.count }.by 2

        expect(Image.all.map {|i| i.uploads.count }).to eq([1, 1])
        expect(response.status).to eq(200)
        json_response = JSON.parse(response.body)
        expect(json_response["data"]).to be_an_instance_of(Array)
        expect(json_response["data"].count).to eq(2)
        expect(json_response["data"].first["attributes"]["urls"].count).to eq(1)
      end
    end
  end

  context "with incorrect request type" do
    let(:headers) { { "CONTENT_TYPE" => "application/json" } }
    it "should error with message" do
      expect do
        post images_path, { params: { }, headers: headers }
      end.to change { Image.count }.by 0

      expect(response.status).to eq(400)
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq("Unsupported request type, please use 'multipart/form-data'")
    end
  end
end
