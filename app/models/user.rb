class User < ActiveRecord::Base
  has_secure_password

  has_many :bookings
  has_many :studios, foreign_key: :owner_id
  has_many :submitted_ratings, foreign_key: :rater_id, class_name: "Rating"
  has_many :ratings, as: :ratable
  has_many :reviews, as: :reviewable
  has_many :written_reviews, foreign_key: :reviewer_id, class_name: "Review"

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  has_attached_file :image, :styles => {:standard => "150x150", :medium => "300x300", :large => "600x600"}
  validates_attachment :image, :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
  validates :password, :length => { :within => 6..20 }, on: :create
  validate :valid_email

  def valid_email
   unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
     errors.add(:email, "must be valid... please.")
   end
 end

  def average_rating
    total = self.ratings.length
    total != 0 ? self.ratings.inject(0) { |sum, rating| sum += rating.value }/self.ratings.count : 0
  end

  def has_studios
    unless self.studios.count == 0
      return true
    end
  end

  def future_bookings
    self.bookings.reject { |booking| booking.start_time.past? }
  end


  def past_bookings
    self.bookings.reject { |booking| booking.start_time.future? }
  end

end
