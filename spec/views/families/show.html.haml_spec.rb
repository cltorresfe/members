require 'rails_helper'

RSpec.describe "families/show", :type => :view do
  before(:each) do
    @family = assign(:family, Family.create!(
      :name => "Name",
      :address => "Address",
      :phone => "Phone",
      :city => "City",
      :country => "Country",
      :church => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(//)
  end
end
