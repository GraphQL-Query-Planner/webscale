FactoryGirl.define do
  factory :photo do
    photo_url 's3.amazon.com/s/photo.jpg'
    association :post, factory: :post
  end
end
