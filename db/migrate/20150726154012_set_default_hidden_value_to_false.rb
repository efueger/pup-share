class SetDefaultHiddenValueToFalse < ActiveRecord::Migration
  def change
    change_column_default  :pups,  :hidden, false
    change_column_default  :users, :hidden, false
    change_column_default  :jobs,  :hidden, false
    change_column_default  :requests, :hidden, false
  end
end
