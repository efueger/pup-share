class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :building
      t.string :address
      t.string :email
      t.string :phone
      t.string :emergency_phone
      t.boolean :parent
      t.boolean :walker

      t.timestamps null: false
    end
  end
end
