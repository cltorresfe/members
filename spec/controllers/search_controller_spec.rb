require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:church) { create(:church) }
  let(:user)   { create(:user, church: church) }

  before do
    sign_in user
  end

  describe 'GET #autocomplete' do
    let!(:member) { create(:member, first_name: 'Primero', church: church) }
    let!(:ministry) { create(:ministry, :with_responsibilities, name: 'Primer', church: church) }
    it 'searchs all members and ministries by query' do
      get :autocomplete, params: { term: 'Primer' }, format: :json
      expect(response.status).to eq 200
    end
  end
end
