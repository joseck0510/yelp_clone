require 'rails_helper'

describe User, type: :model do
  # user = User.create("ty@apps.com", "123456", "123456")
  # restaurant = Restaurant.new(name: "kf")

  it { is_expected.to have_many :reviewed_restaurants }
end
