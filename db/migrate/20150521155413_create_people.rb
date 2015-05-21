class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :building
      t.string :address
      t.string :phone
      t.string :emergency_phone
      t.boolean :pup_parent
      t.boolean :pup_provider

      t.timestamps null: false
    end
  end
end
