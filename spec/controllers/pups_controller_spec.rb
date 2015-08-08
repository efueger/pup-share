require 'rails_helper'

describe PupsController do 

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end

  describe 'GET #index' do
    let(:pup1) { FactoryGirl.create(:pup, user_id: user.id) }
    let(:pup2) { FactoryGirl.create(:pup, user_id: user.id + 1) }

    it 'populates an array of pups belonging to a user' do
      get :index, user_id: user.id
      expect(assigns(:pups)).to match_array([pup1])
    end

    it 'renders the :index template' do
      get :index, user_id: user.id
      expect(response).to render_template :index
    end
  end # GET #index

  describe 'GET #show' do
    let(:pup) { FactoryGirl.create(:pup, user_id: user.id) }

    it 'assigns the requested pup to @pup' do
      get :show, id: pup, user_id: user.id
      expect(assigns(:pup)).to eq pup
    end

    it 'renders the :show template' do
      get :show, id: pup, user_id: user.id
      expect(response).to render_template :show
    end
  end # GET #show

  describe 'GET #new' do
    it 'assigns a new pup to @pup' do
      get :new, user_id: user.id
      expect(assigns(:pup)).to be_a_new(Pup) 
    end
  end # GET #new


  describe 'GET #edit' do
    let(:pup) { FactoryGirl.create(:pup, user_id: user.id) }

    it 'assigns the requested pup to @pup' do
      get :edit, id: pup, user_id: user.id
      expect(assigns(:pup)).to eq pup
    end

    it 'renders the :edit template' do
      get :edit, id: pup, user_id: user.id
      expect(response).to render_template :edit
    end
  end # GET #edit

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new pup in the database' do
        expect{
          post :create, user_id: user.id,
          pup: FactoryGirl.attributes_for(:pup, user_id: user.id)}.to change(Pup, :count).by(1)
      end   

      it 'redirects to user dashboard' do
        post :create, user_id: user.id, 
        pup: FactoryGirl.attributes_for(:pup, user_id: user.id)
        expect(response).to redirect_to new_job_path(user)
      end

      it 'notifies the user of creation' do
        post :create, user_id: user.id, 
        pup: FactoryGirl.attributes_for(:pup, user_id: user.id)
        expect(flash[:notice]). to eql 'You created a pup. Use this form to find a walker'
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new pup in the database' do
        expect{
          post :create, user_id: user.id,
          pup: FactoryGirl.attributes_for(:invalid_pup, user_id: user.id)}.not_to change(Pup, :count)
      end   

      it 're-renders the :new template' do
        post :create, user_id: user.id,
        pup: FactoryGirl.attributes_for(:invalid_pup, user_id: user.id) 
        expect(response).to render_template :new
      end
    end
  end # POST #create

  describe 'PATCH #update' do
    let(:pup) { FactoryGirl.create(:pup, user_id: user.id, pup_name: 'sprinkles', pup_weight: 85) }

    context 'with valid attributes' do

      it 'locates the requested pup' do
        patch :update, user_id: user.id,
        id: pup, pup: FactoryGirl.attributes_for(:pup)
        expect(assigns(:pup)).to eq(pup)
      end

      it 'changes @pup attributes' do
        patch :update, user_id: user.id, id: pup,
        pup: FactoryGirl.attributes_for(:pup, 
          pup_name: 'Toby',
          pup_weight: 65)
        pup.reload
        expect(pup.pup_name).to eq('Toby')
        expect(pup.pup_weight).to eq('65')
      end

      it 'redirects to user\'s dashboard' do
        patch :update, user_id: user.id, id: pup, pup: FactoryGirl.attributes_for(:pup)
        expect(response).to redirect_to user_path(user)
      end
    end # with valid attributes

    context 'with invalid attributes' do
      it 'does not change the pup\'s attributes' do
        patch :update, user_id: user.id, id: pup,
        pup: FactoryGirl.attributes_for(:invalid_pup, 
          pup_name: nil,
          pup_weight: 65)
        pup.reload
        expect(pup.pup_name).to eq('sprinkles')
        expect(pup.pup_weight).to eq('85')
      end

      it 're-renders the :edit template' do
        patch :update, user_id: user.id, id: pup,
        pup: FactoryGirl.attributes_for(:invalid_pup)
        expect(response).to render_template :edit
      end
    end # with invalid attributes
  end # PATCH #update

  describe 'DELETE #destroy' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @pup = FactoryGirl.create(:pup, user_id: @user.id)
    end 

    it 'deletes the pup from the database' do
      expect{delete :destroy, user_id: @user.id, id: @pup}.to change(Pup, :count).by(-1)
    end

    it 'redirects to user\'s dashboard' do
      delete :destroy, user_id: @user.id, id: @pup
      expect(response).to redirect_to user_path(@user)
    end 
  end # DELETE #destroy

end # PupsController