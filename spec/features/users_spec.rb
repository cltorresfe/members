require 'rails_helper'

feature 'Users pages' do
  let!(:user) { create(:user, name: 'Juanito Perez') }
  let(:church) { user.church }
  background { log_in user }

  describe 'edit/update' do
    background { visit profile_path }

    scenario 'editing profile form' do
      expect(page).to have_content 'Editar Perfil'

      expect(page).to have_field('Nombre', with: user.name)
      expect(page).to have_field('Correo electrónico', with: user.email)

      expect(page).to have_field('Nombre', with: church.name)
      expect(page).to have_field('Correo', with: church.email)
      expect(page).to have_field('Dirección', with: church.address)
      expect(page).to have_field('Fono', with: church.phone)
    end

    scenario 'removing user name' do
      fill_in 'Nombre', with: ''
      click_button 'Actualizar Usuario'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'updating user name' do
      expect(page).to have_field('Nombre', with: 'Juanito Perez')
      fill_in 'Nombre', with: 'Don Moncho'
      fill_in 'Contraseña', with: 'password'
      fill_in 'Confirmación de la contraseña', with: 'password'
      click_button 'Actualizar Usuario'
      expect(page).to have_content 'Don Moncho'
    end

    scenario 'updating password' do
      expect(page).to have_field('Nombre', with: 'Juanito Perez')
      fill_in 'Contraseña', with: '123456789'
      fill_in 'Confirmación de la contraseña', with: '123456789'
      click_button 'Actualizar Usuario'
      log_out
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: '123456789'
      click_button "Iniciar sesión"
      expect(page).to have_content 'eDiscípulo'
      expect(page).to have_content "Welcome, #{user.name}"
      expect(page).to have_content 'Inicio'
    end
  end
end
