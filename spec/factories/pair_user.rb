FactoryBot.define do
  factory :pair_user do
    association :user1, factory: :user
    association :user2, factory: :user
  end
end
