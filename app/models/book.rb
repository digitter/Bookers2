class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

  scope :all_with_users, -> { includes(:user).all }
end
