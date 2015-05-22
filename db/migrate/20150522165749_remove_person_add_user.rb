class RemovePersonAddUser < ActiveRecord::Migration
  def change
    remove_column :jobs, :person_id
    add_column    :jobs, :user_id, :integer
    add_index     :jobs, :user_id
  end
end
