require 'rails_helper'

feature 'ministries pages' do
  let!(:user) { create(:user) }
  let!(:director_resp){ create(:responsibility, church: user.church, name: 'Director') }
  let!(:leader_resp){ create(:responsibility, church: user.church, name: 'Lider') }
  background { log_in user }

  describe 'index/show' do
    context 'without ministries' do
      scenario 'displaying a "not found" message' do
        visit ministries_path
        expect(page).to have_content 'No se encontraron ministerios asociados'
      end
    end

    context 'with ministries' do
      let!(:ministry){ create(:ministry, church: user.church, responsibilities: [director_resp]) }
      background { visit ministries_path}

      scenario 'displaying all the ministries' do
        expect(page).to have_content ministry.name
      end

      scenario 'access to ministry details' do
        click_link ministry.name
        expect(page).to have_content 'Editar Ministerio'
        expect(page).to have_field('Nombre', with: ministry.name)
        expect(page).to have_field('Descripción', with: ministry.description)
        expect(page).to have_checked_field("ministry_responsibility_ids_#{director_resp.id}")
        expect(page).not_to have_checked_field("ministry_responsibility_ids_#{leader_resp.id}")
      end
    end
  end

  describe 'new/create' do
    scenario 'tries to create an invalid ministry' do
      visit new_ministry_path
      click_button 'Crear Ministerio'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'creates an admin ministry' do
      visit new_ministry_path
      fill_in 'Nombre', with: 'Escuela Biblica'
      check "ministry_responsibility_ids_#{director_resp.id}"
      click_button 'Crear Ministerio'
      expect(page).to have_content 'Escuela Biblica'
    end

  end

  describe 'edit/update' do
    let!(:ministry){ create(:ministry, church: user.church, responsibilities: [director_resp]) }
    background { visit edit_ministry_path(ministry) }

    scenario 'removing ministry name' do
      fill_in 'Nombre', with: ''
      click_button 'Actualizar Ministerio'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'updating ministry name' do
      expect(page).to have_field('Nombre', with: ministry.name)
      fill_in 'Nombre', with: 'Grupo de Jovenes'
      click_button 'Actualizar Ministerio'
      expect(page).to have_content 'Grupo de Jovenes'
    end
  end

  describe 'destroy' do
    let!(:ministry){ create(:ministry, church: user.church, responsibilities: [director_resp]) }
    background { visit ministries_path }

    context 'ministry with no associations' do
      scenario 'destroys the given ministry' do
        expect(page).to have_content ministry.name
        click_link('', href: "/ministries/#{ministry.id}")
        expect(page).to have_content 'Ministerio fue borrado exitosamente'
        expect(page).to have_content 'No se encontraron ministerios asociados'
        expect(page).not_to have_content ministry.name
      end
    end

    context 'ministry with associated members' do
      let!(:ministry){ create(:ministry, church: user.church, responsibilities: [director_resp]) }
      let!(:member){ create(:member, church: user.church, charges: ministry.charges) }

      scenario 'rejects ministry destroyal' do
        click_link('', href: "/ministries/#{ministry.id}")
        expect(page).not_to have_content 'Ministerio fue borrado exitosamente'
        expect(page).to have_content ministry.name
        expect(page).to have_content 'Uno o más miembros se encuentran asociados a este ministerio. Favor desasociar primero.'
      end
    end
  end
end
