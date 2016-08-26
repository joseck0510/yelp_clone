class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user

  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "You can only have one review per restaurant" }
end
