class Member < ApplicationRecord
  validates :name, presence: true
  belongs_to :family, inverse_of: :members
  has_many :exchanges, class_name: 'Exchange', foreign_key: 'sender_id'
  belongs_to :user
end
