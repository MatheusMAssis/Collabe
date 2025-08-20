# Configure Active Storage to use ImageMagick instead of vips
Rails.application.configure do
  config.active_storage.variant_processor = :mini_magick
end
