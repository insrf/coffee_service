class PairUser < ApplicationRecord
  before_validation :sort_user_ids
  validates :user1_id, uniqueness: { scope: :user2_id }

  private

  def sort_user_ids
    self.user1_id, self.user2_id = [user1_id, user2_id].sort
  end
end
