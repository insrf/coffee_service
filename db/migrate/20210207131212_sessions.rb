class Sessions < ActiveRecord::Migration[6.1]
  def change
    create_sessions
    add_column_to_pair_users
  end

  def create_sessions
    create_table :sessions do |t|

      t.timestamps
    end
  end

  def add_column_to_pair_users
    add_column :pair_users, :session_id, :integer
  end
end
