class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.string :name
      t.string :walker_sitter
      t.datetime :available_from
      t.string :available_location
      t.datetime :available_to
      t.string :dog_size

      t.timestamps null: false
    end
  end
end
