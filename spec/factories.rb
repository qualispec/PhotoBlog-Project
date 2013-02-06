FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Joe #{n}" }
    sequence(:email) { |n| "test-#{n}@test.com" }
  end

  factory :post do
    url "http://domidave.d.o.pic.centerblog.net/o/58e4d4cb.jpg"
    sequence(:body) { |n| "Hello, Kitty #{n}" }
  end

  factory :tag do
    name "test_tag"
  end
end