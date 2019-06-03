class Message < ApplicationRecord
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  def short
    if self.message.length > 20
      self.message.slice(0, 20) + "..."
    else
      self.message
    end
  end
end
