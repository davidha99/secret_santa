class Exchange < ApplicationRecord
  belongs_to :exchange_event, inverse_of: :exchanges
  belongs_to :sender, class_name: 'Member', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Member', foreign_key: 'recipient_id'

  validates :exchange_event, presence: true
end
