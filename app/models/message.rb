class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'

  validates_presence_of :content, :sender_id





end
