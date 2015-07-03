json.array!(@requests) do |request|
  json.extract! request, :id, :requested_by_user_id, :requested_of_user_id, :status, :job_id, :availability_id
  json.url request_url(request, format: :json)
end
