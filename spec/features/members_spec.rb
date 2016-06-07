require 'rails_helper'

describe "Member index", :type => :feature do
  let!(:church) {create(:church)}
  let!(:member) { create(:member, first_name: 'Homero', last_name: 'Humer',church: church)}
  let!(:user) {create(:user, church: church)}

  context "when user is signed in" do
    before do
      login_as user
    end
    it 'loads all the members' do
      visit members_path
      expect(page).to have_content member.first_name
    end
  end

  context " when user is logged out" do
    it 'loads message login' do
      visit members_path
      expect(page).not_to have_content member.first_name
    end
  end

end
