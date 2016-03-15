class Conversation < ActiveRecord::Base
  belongs_to :originator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy





end
