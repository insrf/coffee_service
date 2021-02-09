class GroupeService
  attr_accessor :errors

  def initialize
    @errors = []
  end

  def call
    ActiveRecord::Base.transaction do
      session = Session.create

      pair_ids.each do |pair_id|
        params = { user1_id: pair_id[0], user2_id: pair_id[1], session_id: session.id }
        pair_user = PairUser.create!(params)
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    errors << exception
  end

  private

  def user_ids
    User.pluck(:id)
  end

  def current_pair_ids
    PairUser.pluck(:user1_id, :user2_id)
  end

  def make_pairs_array
    pair_user_ids = []
    array_size = user_ids.size
    all_user_ids = user_ids
    for i in 0..array_size-1 do
      for j in i..array_size-1 do
        pair_user_ids << [all_user_ids[i], all_user_ids[j]] if i != j
      end
    end

    pair_user_ids -= current_pair_ids
  end

  def pair_ids
    pair_user_ids = make_pairs_array.shuffle
    new_pair_ids = []
    i = 0
    while ( i <= pair_user_ids.size - 1) do
      if (pair_user_ids[i] & new_pair_ids.flatten).empty?
        new_pair_ids << pair_user_ids[i]
      end
      i += 1
    end

    if new_pair_ids.size == (user_ids.size / 2)
      new_pair_ids
    else
      @errors << "something went wrong, try again"
      []
    end
  end
end
