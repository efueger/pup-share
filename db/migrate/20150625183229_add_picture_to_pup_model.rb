class AddPictureToPupModel < ActiveRecord::Migration
  def change
    add_column :pups, :pup_pic, :string
  end
end
