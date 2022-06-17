class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.development? || Rails.env.test? #開発とテストは今まで通りに
    storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    storage = :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [550, 550]

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
