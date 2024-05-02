class Member < ApplicationRecord
  validates :name, presence: true
  belongs_to :family
end
