require 'rails_helper'

feature 'Churches' do
  let!(:user) { create(:user, church: nil) }

  background do
    log_in user
  end

  scenario 'rejects access to other sections until user church is created' do
    click_link 'Plataforma Miembros de Iglesia'
    expect(page).not_to have_content 'Inicio'
    expect(page).to have_content 'Nueva Iglesia'
  end

  scenario 'creating an invalid church' do
    click_button 'Crear Iglesia'
    expect(page).to have_content 'Nueva Iglesia'
    expect(page.body).to match 'No puede estar en blanco'
  end

  scenario 'creating a valid church' do
    fill_in 'Nombre', with: 'Presbiteriana'
    fill_in 'Dirección', with: 'Arturo Prat 123'
    fill_in 'Correo', with: 'presbiteriana@iglesia.cl'
    fill_in 'Fono', with: '123456789'
    click_button 'Crear Iglesia'
    expect(page).not_to have_content 'Nueva Iglesia'
    expect(page).to have_content 'Inicio'
  end

  describe 'user with created church' do
    let!(:user) { create(:user) }

    scenario 'redirects to dashboard if tries to create a new church' do
      visit new_church_path
      expect(page.body).to match 'No es posible crear una nueva iglesia'
    end
  end
end
