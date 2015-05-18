class CreatePups < ActiveRecord::Migration
  def change
    create_table :pups do |t|
      t.string :name
      t.string :gender
      t.integer :age

      t.timestamps null: false
    end
  end
end
