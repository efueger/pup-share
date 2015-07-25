class AddHiddenFieldForDataPreservation < ActiveRecord::Migration
  def change
    add_column :pups,  :hidden, :boolean
    add_column :users, :hidden, :boolean
    add_column :jobs,  :hidden, :boolean
    add_column :requests, :hidden, :boolean
  end
end
