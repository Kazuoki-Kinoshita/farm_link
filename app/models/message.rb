class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates_presence_of :body, :conversation_id, :user_id
  validates :body, presence: true
  
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
