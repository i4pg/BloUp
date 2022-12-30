class LinkValidator < ActiveModel::Validator
  def validate(record)
    Down.download(record.link)
  rescue StandardError
    record.errors.add :base, 'Upload an image'
    record.errors.add :base, 'Or enter a valid link'
    record.errors.add :base, 'https://www.example.com/image.jpg'
  else
    validate_link_type(record)
  end

  def validate_link_type(record)
    tempimage = Down.download(record.link)
    unless tempimage.content_type.in?(['image/png', 'image/jpeg', 'image/jpg'])
      record.errors.add :base, 'Invalid type, Please choose an image'
    end
  end
end
