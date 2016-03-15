class Conversation < ActiveRecord::Base
  belongs_to :originator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  #returns conversation objects involving a specific user
  def self.involving(user)
    where("conversations.originator_id = ? OR conversations.recipient_id = ?", user.id, user.id)
  end

  #returns conversation objects between two users
  def self.between(originator, recipient)
    where("(conversations.originator_id = ? AND conversations.recipient_id = ?) OR (conversations.originator_id = ? AND conversations.recipient_id = ?)", originator.id, recipient.id, recipient.id, originator.id)
  end


end
