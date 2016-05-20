require 'rails_helper'

RSpec.describe "families/edit", :type => :view do
  before(:each) do
    @family = assign(:family, Family.create!(
      :name => "MyString",
      :address => "MyString",
      :phone => "MyString",
      :city => "MyString",
      :country => "MyString",
      :church => nil
    ))
  end

  it "renders the edit family form" do
    render

    assert_select "form[action=?][method=?]", family_path(@family), "post" do

      assert_select "input#family_name[name=?]", "family[name]"

      assert_select "input#family_address[name=?]", "family[address]"

      assert_select "input#family_phone[name=?]", "family[phone]"

      assert_select "input#family_city[name=?]", "family[city]"

      assert_select "input#family_country[name=?]", "family[country]"

      assert_select "input#family_church_id[name=?]", "family[church_id]"
    end
  end
end
