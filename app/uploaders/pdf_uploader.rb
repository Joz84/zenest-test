class PdfUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  make_private

  def public_id
    "#{model.reference}_#{model.invoiceable_type}_#{model.invoiceable_id.to_s}"
  end

  def extension_white_list
     %w(jpg jpeg gif png pdf)
   end
end
