class AddUserIdToPupModel < ActiveRecord::Migration
  def change
    add_column :pups, :user_id, :integer
    add_index  :pups, :user_id
  end
end
