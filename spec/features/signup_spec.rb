require 'rails_helper'

feature 'Sign up' do
  let!(:user) { create(:user) }

  background do
    visit new_user_registration_path
  end

  scenario 'creating an invalid user' do
    click_button 'Registrarse'
    expect(page).to have_content 'No puede estar en blanco'
  end

  scenario "creating a valid user and logs in to the system to create the user's church" do
    fill_in 'user[name]', with: 'Homero'
    fill_in 'user[email]', with: 'homero@simpsons.com'
    fill_in 'user[password]', with: '123456789'
    fill_in 'user[password_confirmation]', with: '123456789'
    click_button 'Registrarse'
    expect(page).not_to have_content 'No puede estar en blanco'
    expect(page).to have_content 'Nueva Iglesia'
  end
end
