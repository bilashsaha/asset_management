class AddUserIdToSanchaypatras < ActiveRecord::Migration
  def change
    add_column :sanchaypatras, :user_id, :integer
    add_index(:sanchaypatras, :user_id)
  end
end
