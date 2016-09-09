require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes)   { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:user, name: nil) }

  let(:church) { create(:church) }
  let(:user)   { create(:user, church: church) }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      get :edit
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Juanito Perez' } }

      it 'updates the requested user' do
        put :update, params: { user: new_attributes }
        user.reload
      end

      it 'assigns the requested user as @user' do
        put :update, params: { user: valid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        put :update, params: { user: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        put :update, params: { user: invalid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { user: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end
end
