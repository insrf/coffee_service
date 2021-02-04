class CreatePairUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :pair_users do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.timestamps
    end

    add_index :pair_users, [:user1_id ,:user2_id], unique: true
  end
end
