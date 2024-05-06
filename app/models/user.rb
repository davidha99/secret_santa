class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :families, dependent: :destroy, inverse_of: :user
  has_many :members, dependent: :destroy, inverse_of: :user
  has_many :exchange_events, dependent: :destroy, inverse_of: :user

  def name
    email.split('@').first.capitalize
  end
end
