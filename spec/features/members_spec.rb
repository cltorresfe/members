require 'rails_helper'

describe "Member index", :type => :feature do
  let!(:member) { create(:member, name: 'Homero')}

  it 'loads all the members' do
    visit root_path
    expect(page).to have_content 'Homero'
  end
end
