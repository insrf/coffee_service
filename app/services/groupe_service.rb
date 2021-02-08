class GroupeService
  attr_accessor :errors
  #to do refactoring
  def initialize
    @errors = []
  end

  def call
    ActiveRecord::Base.transaction do
      session = Session.create
      array_ids_dd.each do |element|
        # require "pry"; binding.pry
        element[:session_id] = session.id
        pair_user = PairUser.create!(element)
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    errors << exception
  end

  private

  def array_ids_dd
    array_ids = []

    user_ids = User.all.ids

    loop do
      # возьмем произвольного прользователя
      user_id = user_ids.sample
      # найдем для него не повторяющихся пользователей
      free_opponents_ids = user_ids - [user_id] - PairUser.where(user1_id: user_id).pluck(:user2_id)

      # следующая итерация если для этого пользователя нет пары
      if free_opponents_ids.size == 0
        user_ids -= [user_id]
        # errors << "#{user_id} without opponents"
        break
      end
      # создаем пару
      opponent_id = free_opponents_ids.sample

      # убираем этих пользователей из списка
      user_ids -= [user_id, opponent_id]
      array_ids << { user1_id: user_id, user2_id: opponent_id }
      # выходим из цикла если не осталось юзеров или остался один при условии,
      # что кол-во пользователей было нечетное
      break if user_ids.size <=1
    end
    array_ids
  end
end
