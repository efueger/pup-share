class CreatePups < ActiveRecord::Migration
  def change
    create_table :pups do |t|
      t.string :name
      t.string :breed
      t.integer :weight
      t.string :gender
      t.datetime :birthday
      t.string :picture
      t.boolean :tracking_chip
      t.boolean :neutered
      t.boolean :good_w_dogs
      t.text :special_requirements
      t.text :care_instructions
      t.string :vet_phone

      t.timestamps null: false
    end
  end
end
