class ChangePupGenderDataType < ActiveRecord::Migration
  def change
    change_column :users, :pup_gender, :string
  end
end
