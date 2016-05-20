require 'rails_helper'

describe "Member index", :type => :feature do
  let!(:church) {create(:church)}
  let!(:member) { create(:member, name: 'Homero', church: church)}
  let!(:user) {create(:user, church: church)}

  context "when user is signed in" do
    before do
      login_as user
    end
    it 'loads all the members' do
      visit root_path
      expect(page).to have_content 'Homero'
    end
  end

  context " when user is logged out" do |variable|
    it 'loads message login' do
      visit root_path
      expect(page).to have_content 'iniciar sesión'
    end
  end

end
