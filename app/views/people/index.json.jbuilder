json.array!(@people) do |person|
  json.extract! person, :id, :first_name, :last_name, :building, :address, :email, :phone, :emergency_phone, :pup_parent, :pup_provider
  json.url person_url(person, format: :json)
end
