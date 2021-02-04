FactoryBot.define do
  sequence :name do |n|
    "MyName#{n}"
  end

  factory :user do
    name { "MyName" }
  end

  factory :generate_user, class: "Question" do
    name { generate(:name) }
  end
end
