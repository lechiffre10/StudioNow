class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'

  validates_presence_of :content, :sender_id



  def message_time
    created_at.strftime("%v")
  end


end
