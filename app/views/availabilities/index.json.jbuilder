json.array!(@availabilities) do |availability|
  json.extract! availability, :id, :name, :walker_sitter, :available_from, :available_location, :available_to, :dog_size
  json.url availability_url(availability, format: :json)
end
