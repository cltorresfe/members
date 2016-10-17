require 'rails_helper'

feature 'Members pages' do
  let!(:user) { create(:user) }
  let!(:director_resp) { create(:responsibility, church: user.church, name: 'Director') }
  let!(:leader_resp) { create(:responsibility, church: user.church, name: 'Lider') }
  let!(:ministry) do
    create(:ministry, church: user.church, responsibilities: [director_resp, leader_resp])
  end

  background do
    log_in user
  end

  describe 'index' do
    context 'with members' do
      let!(:member) { create(:member, church: user.church, charges: director_resp.charges) }

      scenario 'displaying all the members' do
        visit members_path
        expect(page).to have_content 'Listado de Miembros'
        expect(page).to have_content user.church.name
        expect(page).to have_content member.first_name
        expect(page).to have_content '1 miembro'
        expect(page).not_to have_content 'No se encontraron miembros ingresados'
      end

      scenario 'access to member details' do
        visit members_path
        click_link('', href: "/members/#{member.id}")
        expect(page).to have_content "Información del Miembro"
        expect(page).to have_content member.first_name
        expect(page).to have_content member.last_name
      end
    end
  end

  describe 'show' do
    context 'with members' do
      let!(:member) { create(:member, church: user.church, charges: director_resp.charges) }

      scenario 'access to member edit' do
        visit member_path(member)
        click_link('', href: "/members/#{member.id}/edit")
        expect(page).to have_content 'Editar Miembro'

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
        expect(page).to have_field('Fecha Nacimiento', with: I18n.l(member.birth_date, format: :just_date), visible: false)
        expect(page).to have_field('Fecha Bautismo', with: I18n.l(member.baptism_date, format: :just_date), visible: false)
        expect(page).to have_field('Fecha Membresía', with: I18n.l(member.membership_date, format: :just_date), visible: false)
        expect(page).to have_field('Fecha Traslado', with: I18n.l(member.transfer_date, format: :just_date), visible: false)
        expect(page).to have_field('Fecha Disciplina', with: I18n.l(member.discipline_date, format: :just_date), visible: false)
        expect(page).to have_field('Testimonio', with: member.testimony, visible: false)
        expect(page).to have_select('Estado', selected: 'Activo', visible: false)

        # Responsibilities
        expect(page).to have_checked_field("member_charge_ids_#{director_resp.charges.last.id}", visible: false)
        expect(page).not_to have_checked_field("member_charge_ids_#{leader_resp.charges.last.id}", visible: false)
      end
    end

    context 'without members' do
      scenario 'Displaying not found message' do
        visit members_path
        expect(page).to have_content 'Listado de Miembros'
        expect(page.body).to match 'No se encontraron miembros ingresados'
      end
    end
  end

  describe 'new/create' do
    scenario 'Creates a new member' do
      visit new_member_path
      fill_in 'Nombres', with: 'Homero'
      fill_in 'Apellidos', with: 'Simpson'
      click_button 'Crear Miembro'
      expect(page).not_to have_content 'No puede estar en blanco'
      expect(page).to have_content 'Homero'
    end

    scenario 'tries to create member without name' do
      visit new_member_path
      click_button 'Crear Miembro'
      # save_and_open_page
      expect(page).to have_content 'No puede estar en blanco'
    end
  end

  describe 'edit/update' do
    let!(:member) { create(:member, church: user.church, charges: director_resp.charges) }
    background { visit edit_member_path(member) }

    scenario 'removing member name' do
      fill_in 'Nombres', with: ''
      fill_in 'Apellidos', with: ''
      click_button 'Actualizar Miembro'
      expect(page).to have_content 'No puede estar en blanco'
    end

    scenario 'updating member name' do
      expect(page).to have_field('Nombres', with: member.first_name)
      expect(page).to have_field('Apellidos', with: member.last_name)
      fill_in 'Nombres', with: 'Marge'
      fill_in 'Apellidos', with: 'Simpsons'
      click_button 'Actualizar Miembro'
      expect(page).to have_content 'Marge Simpsons'
    end
  end

  describe 'destroy' do
    let!(:member) { create(:member, church: user.church, charges: director_resp.charges) }
    background { visit member_path(member) }

    context 'member with no associations' do
      scenario 'destroys the given member' do
        expect(page).to have_content member.full_name
        click_link('Borrar')
        expect(page.body).to match 'No se encontraron miembros ingresados'
        expect(page).not_to have_content member.full_name
      end
    end
  end

  describe 'send_mail' do
    background { visit member_path(member) }

    context 'member with email and subject' do
      let!(:member) { create(:member, church: user.church) }
      scenario 'sends email to member' do
        click_button('Enviar Mensaje')
        fill_in 'Asunto', with: 'subject'
        click_button('Enviar Correo')
        expect(page.body).to match  'Se ha enviado el correo satisfactoriamente.'
      end
    end

    context 'member with email and without subject' do
      let!(:member) { create(:member, church: user.church) }
      scenario 'sends email to member', js: true do
        click_button('Enviar Mensaje')
        click_button('Enviar Correo')
        expect(page).to have_content 'Campo requerido'
      end
    end

    context 'member without email' do
      let!(:member) { create(:member, church: user.church, email: nil) }
      scenario 'sends email to member' do
        expect(page).not_to have_content 'Enviar Mensaje'
      end
    end
  end

  describe 'associated_family' do
    background { visit member_path(member) }
    let!(:family) { create(:family, church: user.church, name: 'familiaT') }

    context 'member without family associated' do
      let!(:member) { create(:member, church: user.church, family: nil) }
      scenario 'associated family to member' do
        click_button('Asociar Familia')
        select('Padre', from: 'Rol')
        have_select('Familia', selected: family.name)
        click_button('Actualizar Miembro')
        expect(page.body).to match 'Miembro ha sido actualizado satisfactoriamente.'
      end
    end

    context 'member with family associated' do
      let!(:member) { create(:member, church: user.church, family: family) }
      scenario 'associated family to member' do
        click_button('Cambiar Familia')
        select('Padre', from: 'Rol')
        have_select('Familia', selected: family.name)
        click_button('Actualizar Miembro')
        expect(page.body).to match 'Miembro ha sido actualizado satisfactoriamente.'
      end
    end

    context 'member with head family associated' do
      let!(:member_head) { create(:member, church: user.church, family: family, role: :head_family) }
      let!(:member) { create(:member, church: user.church, family: family) }
      scenario 'associated family to member' do
        click_button('Cambiar Familia')
        select('Jefe de Familia', from: 'Rol')
        have_select('Familia', selected: family.name)
        click_button('Actualizar Miembro')
        expect(page.body).to match 'ya es un Jefe de Familia'
      end
    end
  end

  describe 'add_tithes' do
    background { visit member_path(member) }
    let!(:member) { create(:member, church: user.church) }
    let!(:tithe) { create(:tithe, church: user.church, member: member) }

    scenario 'adds tithe to member' do
      click_button('Diezmo')
      fill_in 'Fecha entrega', with: I18n.l(Time.now, format: :just_date)
      fill_in 'Cantidad', with: '3000'

      click_button('Crear Diezmo')
      expect(page.body).to match 'Diezmo ha sido agregado satisfactoriamente'
    end
  end
end
