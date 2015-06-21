class DropSomeUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :walker
    remove_column :users, :parent
  end
end
