class Family < ApplicationRecord
  validates :name, presence: true
  has_many :members, dependent: :destroy
  accepts_nested_attributes_for :members

  scope :ordered, -> { order(id: :desc) }
end
