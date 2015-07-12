class PupPicUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  process resize_to_fill: [200, 200]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "pup_walk.png"].compact.join('_'))
  end
end
