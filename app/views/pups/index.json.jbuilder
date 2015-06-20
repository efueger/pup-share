json.array!(@pups) do |pup|
  json.extract! pup, :id
  json.url pup_url(pup, format: :json)
end
