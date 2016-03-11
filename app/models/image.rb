class Image < ActiveRecord::Base
  belongs_to :studio
  has_attached_file :media, :styles => {:standard => "150x150"}, :bucket => 'studio-now', :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }

  validates_attachment_presence :media
  validates_attachment :media, :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
end
