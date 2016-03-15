class Conversation < ActiveRecord::Base
  belongs_to :originator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  #returns collection of conversation objects involving a specific user
  def self.involving(user)
    where("conversations.originator_id = ? OR conversations.recipient_id = ?", user.id, user.id)
  end

  #returns single conversation object between two users
  def self.between(originator, recipient)
    where("(conversations.originator_id = ? AND conversations.recipient_id = ?) OR (conversations.originator_id = ? AND conversations.recipient_id = ?)", originator.id, recipient.id, recipient.id, originator.id).first
  end




end
