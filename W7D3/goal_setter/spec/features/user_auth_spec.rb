require 'rails_helper'

feature 'Sign Up' do
    background :each do
        visit new_user_url
    end

    scenario 'has a sign-up page' do
        expect(page).to have_content('Create New User')
    end

    scenario 'takes a username, password, email, age' do
        expect(page).to have_content('Username')
        expect(page).to have_content('Password')
        expect(page).to have_content('Email')
        expect(page).to have_content('Age')
    end

    scenario "redirects to the user's show page and displays username on success" do
        fill_in 'user[username]', with: 'Michelle_AA'
        fill_in 'email', with: 'Michelle@aa.io'
        fill_in 'Password', with: 'dannyismyfavoritestudent'
        fill_in 'Age', with: '27'

        click_button 'Create User'

        expect(page).to have_content('Michelle_AA')
        user = User.find_by(username: 'Michelle_AA')
        expect(current_url).to eq(user_url(user))

    end



end