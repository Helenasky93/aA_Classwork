require 'rails_helper'

feature 'Sign Up' do #feature => describe

    background :each do #background => before
        visit new_user_url
    end

    scenario 'has a sign-up page' do #scenario => it
        expect(page).to have_content('Create New User')
    end

    scenario 'takes a username, password, email, age' do
        # using the label
        expect(page).to have_content('Username')
        expect(page).to have_content('Password')
        expect(page).to have_content('Email')
        expect(page).to have_content('Age')
    end

    scenario "redirects to the user's show page and displays username on success" do
        #using the name attribute on input tag
        fill_in 'user[username]', with: 'RAYZAH_BLAYDES'

        #using the input id
        fill_in 'email', with: 'DOWN_UNDAH@aa.io'

        #using the label
        fill_in 'Password', with: 'dingos'
        fill_in 'Age', with: 70

        click_button "Create User" 
        # save_and_open_page

        expect(page).to have_content('RAYZAH_BLAYDES')
        user = User.find_by(username: 'RAYZAH_BLAYDES')

        # expect(current_path).to eq(user_path(user))
        expect(current_url).to eq(user_url(user))
    end 

end