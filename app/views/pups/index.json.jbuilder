json.array!(@pups) do |pup|
  json.extract! pup, :id, :name, :gender, :age
  json.url pup_url(pup, format: :json)
end
