require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not signed in' do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it "should NOT see a 'sign out' link" do
      visit('/')
      expect(page).not_to have_link 'Sign out'
    end

    it 'should not be able to create a restaurant' do
      visit('/')
      click_link "Add a restaurant"
      expect(page).to have_content('Log in')
    end
  end

  context 'User signed in' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in 'Email', with: 'jonny@test.com'
      fill_in 'Password', with: 'secret'
      fill_in 'Password confirmation', with: 'secret'
      click_button 'Sign up'
    end

    it "should see a 'sign out' link" do
      visit('/')
      expect(page).to have_link "Sign out"
    end

    it "should not see a 'sign in' link or a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link "Sign in"
      expect(page).not_to have_link "Sign up"
    end

  end
end
