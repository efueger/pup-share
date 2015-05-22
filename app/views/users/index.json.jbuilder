json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :building, :address, :email, :phone, :emergency_phone, :parent, :walker
  json.url user_url(user, format: :json)
end
