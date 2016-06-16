require 'rails_helper'

feature "Members pages" do
  let!(:user) { create(:user) }

  background do
    log_in user
  end

  describe 'index' do

    context 'with members' do
      let!(:member){ create(:member, church: user.church) }

      scenario "Displaying all the members" do
        visit members_path
        expect(page).to have_content "Listado de Miembros"
        expect(page).to have_content user.church.name
        expect(page).to have_content member.first_name
        expect(page).to have_content "1 miembro"
        expect(page).not_to have_content 'No se encontraron miembros ingresados'
      end

      scenario "Access to member details" do
        visit members_path
        click_link member.first_name
        expect(page).to have_content "Editar Miembro"

        # Basic info
        expect(page).to have_field('Nombres', with: member.first_name)
        expect(page).to have_field('Apellidos', with: member.last_name)
        expect(page).to have_checked_field('member[gender]', with: member.gender)
        expect(page).to have_field('Dirección', with: member.address)
        expect(page).to have_field('Run', with: member.run)
        expect(page).to have_field('Ciudad', with: member.city)
        expect(page).to have_select('País', selected: member.country_name)

        # Contact info
        expect(page).to have_field('Correo', with: member.email, visible: false)
        expect(page).to have_field('Fono', with: member.phone, visible: false)
        expect(page).to have_field('Twitter', with: member.twitter, visible: false)
        expect(page).to have_field('Facebook', with: member.facebook, visible: false)
        expect(page).to have_field('Skype', with: member.skype, visible: false)

        # Membership info
        expect(page).to have_field('Fecha Nacimiento', with: I18n.l(member.birth_date, format: :just_time), visible: false)
        expect(page).to have_field('Fecha Bautismo', with: I18n.l(member.baptism_date, format: :just_time), visible: false)
        expect(page).to have_field('Fecha Membresía', with: I18n.l(member.membership_date, format: :just_time), visible: false)
        expect(page).to have_field('Fecha Traslado', with: I18n.l(member.transfer_date, format: :just_time), visible: false)
        expect(page).to have_field('Fecha Disciplina', with: I18n.l(member.discipline_date, format: :just_time), visible: false)
        expect(page).to have_field('Testimonio', with: member.testimony, visible: false)
        expect(page).to have_select('Estado', selected: 'Activo', visible: false)

      end
    end

    context 'without members' do
      scenario "Displaying not found message" do
        visit members_path
        expect(page).to have_content "Listado de Miembros"
        expect(page).to have_content 'No se encontraron miembros ingresados'
      end
    end
  end

  describe 'new/create' do
    scenario "Creates a new member" do
      visit new_member_path
      fill_in 'Nombres', with: 'Homero'
      fill_in 'Apellidos', with: 'Simpson'
      click_button "Crear Miembro"
      expect(page).not_to have_content "No puede estar en blanco"
      expect(page).to have_content "Homero"
    end

    scenario "Tries to create member without name" do
      visit new_member_path
      click_button "Crear Miembro"
      # save_and_open_page
      expect(page).to have_content "No puede estar en blanco"
    end
  end

end
