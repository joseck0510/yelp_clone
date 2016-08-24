def sign_up(email: "jonny@gmail.com",
            password: "password",
            password_confirmation: "password")
  visit '/users/sign_up'
  expect(page.status_code).to eq(200)
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end

# def harry_creates_restaurant
#   harry = User.create(email: "harry@hasrestaurant.com",
#                       password: "password",
#                       password_confirmation: "password")
#   bk = Restaurant.new(name: "Burger King")
#   bk.user = harry
#   bk.save
# end

def jonny_creates_a_restaurant
  sign_up
  click_link "Add a restaurant"
  fill_in "Name", with: "Central Perk"
  click_button "Create Restaurant"
end
