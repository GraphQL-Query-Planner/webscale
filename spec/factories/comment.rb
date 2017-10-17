FactoryGirl.define do
  factory :comment do
    body 'Hello, World!'
    association :author, factory: :user

    factory :post_comment do
      association :content, factory: :post
    end

    factory :photo_comment do
      association :content, factory: :photo
    end
  end
end
