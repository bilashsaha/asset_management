class CreateSanchaypatras < ActiveRecord::Migration
  def change
    create_table :sanchaypatras do |t|
      t.string :reg_number
      t.date :issue_date
      t.decimal :amount
      t.decimal :profit_per_lac
      t.date :active_date
      t.date :expire_date
      t.decimal :profilt_percentage
      t.integer :interval_month

      t.timestamps null: false
    end
  end
end
