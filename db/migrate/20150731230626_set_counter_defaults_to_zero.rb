class SetCounterDefaultsToZero < ActiveRecord::Migration
  def change
    # change_column :table_name, :column_name, :type, default: "Your value"
    change_column :pups, :walks_completed, :integer, default: 0
    change_column :users, :awesome_count, :integer, default: 0
    change_column :users, :not_good_count, :integer, default: 0
    change_column :users, :no_show_count, :integer, default: 0
    change_column :users, :walks_completed, :integer, default: 0
  end
end
