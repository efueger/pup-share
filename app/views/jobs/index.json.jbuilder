json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :job_type, :drop_off_time, :drop_off_location, :pick_up_time, :pick_up_location
  json.url job_url(job, format: :json)
end
