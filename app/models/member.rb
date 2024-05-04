class Member < ApplicationRecord
  validates :name, presence: true
  belongs_to :family, inverse_of: :members
  has_many :given_gifts, class_name: 'Exchange', foreign_key: 'sender_id'
  scope :ordered, -> { order(id: :asc) }
end
