class AddUserIdToRequestModel < ActiveRecord::Migration
  def change
    rename_column :requests, :requested_by_user_id, :user_id
  end
end
