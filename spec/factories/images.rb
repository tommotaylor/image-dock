FactoryBot.define do
  factory :image do
    trait :jpg do
      after(:build) do |image|
        image.uploads.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'bill-murray.jpg')),
          filename: 'bill-murray.jpg',
          content_type: 'image/jpg'
        )
      end
    end

    trait :png do
      after(:build) do |image|
        image.uploads.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'bill-murray.png')),
          filename: 'bill-murray.png',
          content_type: 'image/jpg'
        )
      end
    end
  end
end
