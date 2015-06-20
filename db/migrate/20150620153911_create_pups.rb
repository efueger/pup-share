class CreatePups < ActiveRecord::Migration
  def change
    create_table :pups do |t|

      t.timestamps null: false
    end
  end
end
