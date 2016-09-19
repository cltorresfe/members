require 'rails_helper'

RSpec.describe FamiliesController, type: :controller do
  let(:valid_attributes)   { attributes_for(:family) }
  let(:invalid_attributes) { attributes_for(:family, name: nil) }

  let(:church) { create(:church) }
  let(:user)   { create(:user, church: church) }
  let!(:family) { create(:family, church: church) }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'assigns all families as @families' do
      get :index
      expect(assigns(:families)).to eq([family])
    end
  end

  describe 'GET new' do
    it 'assigns a new family as @family' do
      get :new
      expect(assigns(:family)).to be_a_new(Family)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested family as @family' do
      get :edit, params: { id: family.id }
      expect(assigns(:family)).to eq(family)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Family' do
        expect do
          post :create, params: { family: valid_attributes }
        end.to change(Family, :count).by(1)
      end

      it 'assigns a newly created family as @family', focus: true do
        post :create, params: { family: valid_attributes }
        expect(assigns(:family)).to be_a(Family)
        expect(assigns(:family)).to be_persisted
      end

      it 'redirects to the created family' do
        post :create, params: { family: valid_attributes }
        expect(response).to redirect_to(families_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved family as @family' do
        post :create, params: { family: invalid_attributes }
        expect(assigns(:family)).to be_a_new(Family)
      end

      it "re-renders the 'new' template" do
        post :create, params: { family: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'Foo' } }

      it 'updates the requested family' do
        put :update, params: { id: family.id, family: new_attributes }
        family.reload
        expect(family.name).to eq 'Foo'
      end

      it 'assigns the requested family as @family' do
        put :update, params: { id: family.id, family: valid_attributes }
        expect(assigns(:family)).to eq(family)
      end

      it 'redirects to the family' do
        put :update, params: { id: family.id, family: valid_attributes }
        expect(response).to redirect_to(families_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the family as @family' do
        put :update, params: { id: family.id, family: invalid_attributes }
        expect(assigns(:family)).to eq(family)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: family.id, family: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy', focus: true do
    it 'destroys the requested family' do
      expect do
        delete :destroy, params: { id: family.id }
      end.to change(Family, :count).by(-1)
    end

    it 'redirects to the families list' do
      delete :destroy, params: { id: family.id }
      expect(response).to redirect_to(families_url)
    end
  end
end
