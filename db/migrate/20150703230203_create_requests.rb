class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requested_by_user_id
      t.integer :requested_of_user_id
      t.string :status
      t.integer :job_id
      t.integer :availability_id

      t.timestamps null: false
    end
  end
end
