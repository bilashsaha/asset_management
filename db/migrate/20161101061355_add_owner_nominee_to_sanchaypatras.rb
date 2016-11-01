class AddOwnerNomineeToSanchaypatras < ActiveRecord::Migration
  def change
    add_column :sanchaypatras, :owner_name, :string
    add_column :sanchaypatras, :nominee_name, :string
  end
end
