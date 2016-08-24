require 'rails_helper'
require 'web_helper'

feature 'Restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'Restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'displays restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'Creating restaurants' do
    scenario 'should be able to add a restaurant' do
      sign_up
      visit '/restaurants'
      click_link "Add a restaurant"
      fill_in "Name", with: "KFC"
      click_button "Create Restaurant"
      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "KFC"
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'Viewing restaurants' do
    let!(:kfc) { Restaurant.create(name: 'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'Editing restaurants' do
    scenario 'lets users edit restaurants' do
      jonny_creates_a_restaurant
      click_link "Edit Central Perk"
      fill_in 'Name', with: 'Central Perk'
      fill_in 'Description', with: 'Gunther cracks me up'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Central Perk'
      expect(page).to have_content 'Gunther cracks me up'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'users cannot edit restaurants that they did not create' do
      jonny_creates_a_restaurant
      click_link "Sign out"
      sign_up(email: "harry@norestaurant")
      visit '/restaurants'
      expect(page).not_to have_content("Edit Central Perk")

    end
  end

  context 'Deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a link' do
      jonny_creates_a_restaurant
      click_link 'Delete Central Perk'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'user can only delete restaurants they created' do
      jonny_creates_a_restaurant
      click_link "Sign out"
      sign_up(email: "jose@aintgotnorestaurant")
      visit '/restaurants'
      expect(page).not_to have_content("Delete Central Perk")
    end
  end

end
