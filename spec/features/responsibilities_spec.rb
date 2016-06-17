require 'rails_helper'

feature 'Responsibilities pages' do
  let!(:user) { create(:user) }
  background { log_in user }

  describe 'index/show' do
    context 'without responsibilities' do
      scenario 'displaying a "not found" message' do
        visit responsibilities_path
        expect(page).to have_content 'No se encontraron cargos asociados'
      end
    end

    context 'with responsibilities' do
      let!(:responsibility){ create(:responsibility, church: user.church) }
      background { visit responsibilities_path}

      scenario 'displaying all the responsibilities' do
        expect(page).to have_content responsibility.name
      end

      scenario 'access to responsibility details' do
        click_link responsibility.name
        expect(page).to have_content 'Editar Cargo'
        expect(page).to have_field('Nombre', with: responsibility.name)
        expect(page).to have_checked_field('responsibility[administrative]')
      end
    end
  end

  describe 'new/create' do
    scenario 'tries to create an invalid responsibility' do
      visit new_responsibility_path
      click_button 'Crear Cargo'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'creates an admin responsibility' do
      visit new_responsibility_path
      fill_in 'Nombre', with: 'Lider'
      check 'responsibility[administrative]'
      click_button 'Crear Cargo'
      expect(page).to have_content 'Lider'
    end

  end

  describe 'edit/update' do
    let!(:responsibility){ create(:responsibility, church: user.church) }
    background { visit edit_responsibility_path(responsibility) }

    scenario 'removing responsibility name' do
      fill_in 'Nombre', with: ''
      click_button 'Actualizar Cargo'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'updating responsibility name' do
      expect(page).to have_field('Nombre', with: 'Director')
      fill_in 'Nombre', with: 'Lider'
      click_button 'Actualizar Cargo'
      expect(page).to have_content 'Lider'
    end
  end

  describe 'destroy' do
    let!(:responsibility){ create(:responsibility, church: user.church) }
    background { visit responsibilities_path }

    context 'responsibility with no associations' do
      scenario 'destroys the given responsibility' do
        expect(page).to have_content responsibility.name
        click_link('', href: "/responsibilities/#{responsibility.id}")
        expect(page).to have_content 'Cargo fue borrado exitosamente'
        expect(page).to have_content 'No se encontraron cargos asociados'
        expect(page).not_to have_content responsibility.name
      end
    end

    context 'responsibility with ministries associated' do
      let!(:ministry){ create(:ministry, church: user.church, responsibilities: [responsibility]) }

      scenario 'rejects responsibility destroyal' do
        click_link('', href: "/responsibilities/#{responsibility.id}")
        expect(page).not_to have_content 'Cargo fue borrado exitosamente'
        expect(page).to have_content responsibility.name
        expect(page).to have_content 'Cargo se encuentra asociado a un ministerio. Favor desasociar primero.'
      end
    end
  end
end
