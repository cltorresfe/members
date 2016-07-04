require 'rails_helper'

feature "Sign in" do
  let!(:user) { create(:user) }

  describe "when user has signed in" do
    background do
      log_in user
    end

    scenario 'loads the Dashboard' do
      expect(page).to have_content 'Plataforma Miembros de Iglesia'
      expect(page).to have_content "Welcome, #{user.name}"
      expect(page).to have_content 'Inicio'
    end

    scenario 'logs out from the app' do
      log_out
      expect(page).not_to have_content 'Plataforma Miembros de Iglesia'
      expect(page).to have_content 'Iniciar sesión'
    end

    context 'without church created' do
      let!(:user) { create(:user, church: nil) }

      scenario 'logs out from the app' do
        log_out
        expect(page).not_to have_content 'Plataforma Miembros de Iglesia'
        expect(page).to have_content 'Iniciar sesión'
      end
    end
  end

  describe "when user has logged out" do
    scenario 'loads message login' do
      visit root_path
      expect(page).not_to have_content 'Plataforma Miembros de Iglesia'
      expect(page).to have_content 'Iniciar sesión'
    end
  end

end
