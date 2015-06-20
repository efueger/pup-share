class CreatePups < ActiveRecord::Migration
  def change
    create_table :pups do |t|

      t.string   :pup_name
      t.string   :pup_breed
      t.string   :pup_weight
      t.string   :pup_gender
      t.string   :pup_vet_phone
      t.text     :pup_care_instructions
      t.integer  :pup_age
      t.integer  :user_id

      t.timestamps null: false
    end
  end
end
