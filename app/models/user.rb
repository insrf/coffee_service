class User < ApplicationRecord
  has_many :pair_users, foreign_key: "user1_id", dependent: :destroy
end
