class Family < ApplicationRecord
  validates :name, presence: true
  has_many :members, dependent: :destroy, inverse_of: :family

  scope :ordered, -> { order(id: :desc) }
end
