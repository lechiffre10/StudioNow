class Rating < ActiveRecord::Base
  belongs_to :ratable, polymorphic: true
  belongs_to :rater, class_name: 'User'

  validates :score, presence: true
end
