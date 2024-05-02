class Member < ApplicationRecord
  validates :name, presence: true
  belongs_to :family
  scope :ordered, -> { order(id: :asc) }
end
