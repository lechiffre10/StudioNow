class Rating < ActiveRecord::Base
  belongs_to :ratable, polymorphic: true
  belongs_to :rater, class_name: 'User'

  validates :value, presence: true
end
