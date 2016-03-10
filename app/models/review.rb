class Review < ActiveRecord::Base
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewer, class_name: 'User'

  validates :content, presence: true
end
