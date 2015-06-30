class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :available_from
      t.datetime :available_to
      t.text :location
      t.text :comment
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end