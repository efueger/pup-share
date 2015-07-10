class AddPupIdToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :pup_id, :integer
  end
end
