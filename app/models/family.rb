class Family < ApplicationRecord
  validates :name, presence: true
  has_many :members, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }
end
