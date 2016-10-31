class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :sanchaypatra_id
      t.integer :token_number
      t.date :token_date
      t.boolean :is_redeemed, :default => false

      t.timestamps null: false
    end

    add_index(:tokens,:sanchaypatra_id)
  end
end
