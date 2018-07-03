FactoryBot.define do
  factory :image do
    after(:build) do |image|
      image.uploads.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'bill-murray.jpg')),
        filename: 'bill-murray.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
