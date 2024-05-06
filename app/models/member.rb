class Member < ApplicationRecord
  validates :name, presence: true
  belongs_to :family, inverse_of: :members
  belongs_to :user
  has_many :exchanges_as_sender, class_name: 'Exchange', foreign_key: 'sender_id', dependent: :destroy
  has_many :exchanges_as_recipient, class_name: 'Exchange', foreign_key: 'recipient_id', dependent: :destroy
end
