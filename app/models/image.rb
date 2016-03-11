class Image < ActiveRecord::Base
  belongs_to :studio
  has_attached_file :image, :styles => {:standard => "150x150"}
  validates_attachment_presence :image
  validates_attachment :image, :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
end
