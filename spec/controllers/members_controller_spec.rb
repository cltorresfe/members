require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:user) { create(:user)}

  before do
    sign_in user
  end

  describe "POST #send_mail" do
    let!(:member) { create(:member)}

    before { xhr :post, :send_mail, params: attributes }
    subject { response }
    
    context "without subject" do
      let(:attributes) { { subject: nil, id: member.id } }
      
      it {is_expected.to have_http_status(:unprocessable_entity)}
    end

    context "sending email to unallowed member" do
      let(:attributes) { { subject: 'foo', id: member.id } }
      
      it {is_expected.to have_http_status(:forbidden)}
    end
  end
end
