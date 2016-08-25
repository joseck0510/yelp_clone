require 'rails_helper'

feature "restaurants" do

  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end



  context 'creating restaurants' do

    scenario 'prompt user to fill out form and then display restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

    scenario 'will not work if user not signed-in' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'let a user edit a restaurant' do
      sign_up
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'let a user delete a restaurant' do
      sign_up
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'No restaurants yet'
    end
  end
end


def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end
