require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:church) { create(:church)}
  let(:user)   { create(:user, church: church)}

  before do
    sign_in user
  end

  describe "POST #send_mail" do
    context "with valid params" do
      let!(:member) { create(:member)}
      let(:attributes) { { subject: nil, id: member.id } }
      
      it "sends messages error" do
        xhr :post, :send_mail, params: attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
