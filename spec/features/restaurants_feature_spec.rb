require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
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

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      signup
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      attach_file 'restaurant[image]', Rails.root.join('spec','images','bbc-g.jpg')
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do

      it 'does not let you submit a name that is too short' do
        signup
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end

    end

    context 'must be signed in' do
      it 'does not let you add a restaurant if not signed in' do
        visit '/'
        click_link 'Add a restaurant'
        expect(page).to have_content 'Log in'
      end
    end

  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before {Restaurant.create name: 'KFC'}

    scenario 'let a user edit a restaurant' do
      signup
      create_restaurant
      visit '/restaurants'
      click_link 'Edit Wagamama'
      fill_in 'Name', with: 'Wagamamama'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Wagamamama'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'users can only edit own restaurants' do
      signup
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Sorry - you can only edit your own posts'
    end

  end

  context 'deleting restaurants' do

    scenario 'let a user delete a restaurant' do
      signup
      create_restaurant
      visit '/restaurants'
      click_link 'Delete Wagamama'
      expect(page).not_to have_content 'Wagamama'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end


end
