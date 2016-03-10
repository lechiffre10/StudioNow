class User < ActiveRecord::Base
  has_secure_password

  has_many :bookings
  has_many :studios, foreign_key: :owner_id
  has_many :submitted_ratings, foreign_key: :rater_id
  has_many :ratings, as: :ratable
  has_many :written_reviews, foreign_key: :reviewer_id
  has_many :reviews, as: :reviewable

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  has_attached_file :image, :styles => {:standard => "150x150"}
  validates_attachment :image, :content_type => {:content_type => /^image\/jpeg|png|gif|tiff)$/}
  validates :password, :length => { :within => 6..20 }
  validate :valid_email

  def valid_email
   unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
     errors.add(:email, "must be valid... please.")
   end
 end

end
