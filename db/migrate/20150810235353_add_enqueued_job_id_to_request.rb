class AddEnqueuedJobIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :enqueued_job_id, :integer
  end
end
