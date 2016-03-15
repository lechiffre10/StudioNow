class User < ActiveRecord::Base
  has_secure_password
  ratyrate_rater
  ratyrate_rateable

  has_many :bookings
  has_many :studios, foreign_key: :owner_id
  has_many :ratings_given, class_name: 'Rate', foreign_key: :rater_id
  has_many :rates_without_dimension, -> { where dimension: nil}, as: :rateable, class_name: 'Rate', dependent: :destroy
  has_many :reviews, as: :reviewable
  has_many :written_reviews, foreign_key: :reviewer_id, class_name: "Review"
  has_many :originated_conversations, foreign_key: :originator_id, class_name: "Conversation"
  has_many :received_conversations, foreign_key: :recipient_id, class_name: "Conversation"
  has_many :messages, foreign_key: :sender_id, class_name: "Message"

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  has_attached_file :image, :styles => {:standard => "150x150", :medium => "300x300", :large => "600x600"}
  validates_attachment :image, :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
  validates :password, :length => { :within => 6..20 }, on: :create
  validate :valid_email
  before_save :valid_soundcloud_url

  def valid_soundcloud_url
    self.soundcloud_url ||= "https://soundcloud.com/subpop/kristin-kontrol-x-communicate"
  end

  def valid_email
   unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
     errors.add(:email, "must be valid... please.")
   end
 end

  def average_rating
    total = self.rates.length
    total != 0 ? self.rates.inject(0) { |sum, rating| sum += rating.stars.to_i }/self.rates.count : 0
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
