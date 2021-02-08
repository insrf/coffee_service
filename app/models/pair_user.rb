class PairUser < ApplicationRecord

  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  belongs_to :session

  before_validation :sort_user_ids
  validates :user1_id, uniqueness: { scope: :user2_id }
  before_validation :set_session_id

  private

  def sort_user_ids
    self.user1_id, self.user2_id = [user1_id, user2_id].sort
  end

  def set_session_id
    self.session_id ||= Session.create.id
  end
end
