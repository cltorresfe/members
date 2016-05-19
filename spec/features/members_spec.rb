require 'rails_helper'

describe "Member index", :type => :feature do
  let!(:member) { create(:member, name: 'Homero')}
  let!(:user) {create(:user)}

  context "cuando el usuario está logeado" do
    before do
      login_as user
    end
    it 'loads all the members' do
      visit root_path
      expect(page).to have_content 'Homero'
    end
  end

  context " cuando el usuario no está logeado" do |variable|
    it 'loads message login' do
      visit root_path
      expect(page).to have_content 'iniciar sesión'
    end
  end

end
