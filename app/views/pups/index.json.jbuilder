json.array!(@pups) do |pup|
  json.extract! pup, :id, :name, :breed, :weight, :gender, :birthday, :picture, :tracking_chip, :neutered, :good_w_dogs, :special_requirements, :care_instructions, :vet_phone
  json.url pup_url(pup, format: :json)
end
