FactoryBot.define do
  sequence :name do |n|
    "MyName#{n}"
  end

  factory :user do
    name { "MyName" }
  end
end
