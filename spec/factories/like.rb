FactoryGirl.define do
  factory :like do
    association :user, factory: :user

    factory :post_like do
      association :content, factory: :post
    end

    factory :photo_like do
      association :content, factory: :photo
    end

    factory :comment_like do
      association :content, factory: :comment
    end
  end
end
