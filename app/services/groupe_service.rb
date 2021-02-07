class GroupeService
  def call
    user_ids = User.all.ids

    loop do
      # возьмем произвольного прользователя
      user_id = user_ids.sample
      # найдем для него не повторяющихся пользователей
      free_opponents_ids = user_ids - [user_id] - PairUser.where(user1_id: user_id).pluck(:user2_id)

      # следующая итерация если для этого пользователя нет пары
      if free_opponents_ids.size == 0
        user_ids -= user_id
        next
      end
      # создаем пару
      opponent_id = free_opponents_ids.sample
      PairUser.create(user1_id: user_id, user2_id: opponent_id)

      # убираем этих пользователей из списка
      user_ids -= [user_id, opponent_id]

      # выходим из цикла если не осталось юзеров или остался один при условии,
      # что кол-во пользователей было нечетное
      break if user_ids.size <=1
    end
  end
end
