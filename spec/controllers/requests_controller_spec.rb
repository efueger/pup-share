require 'rails_helper'

describe RequestsController do 

  let(:requested_of_user) { FactoryGirl.create(:user) }
  let(:job) { FactoryGirl.create(:job) }

  describe 'GET #index' do
    before :each do
      sign_in @user = FactoryGirl.create(:user) 
    end

    let(:request1) { FactoryGirl.create(:request, user_id: @user.id, status: 'approved') }
    let(:request2) { FactoryGirl.create(:request, user_id: @user.id) }    

    it 'renders the :index template' do
      get :index, user_id: @user.id
      expect(response).to render_template :index
    end
  end #GET #index

  describe 'GET #new' do
    it 'assigns a new request to @request' do
      sign_in @user = FactoryGirl.create(:user) 
      get :new, id: request, user_id: @user.id
      expect(assigns(:request)).to be_a_new(Request)       
    end
  end #GET #new

  describe 'GET #edit' do

    let(:user) { FactoryGirl.create(:user) } 
    let(:requested_of_user) { FactoryGirl.create(:user) } 
    let(:my_request) { FactoryGirl.create(:request, user_id: user.id,
      requested_of_user_id: requested_of_user.id, job_id: job.id) }

    context 'request exists' do
      it 'and redirects to the user dashboard' do
        get :edit, id: my_request, user_id: user.id
        expect(response.status).to eq(200)
      end

      it 'and walk approved notifies' do 
      end

      it 'walk declined notifies'
      it 'walk cancelled notifies'
    end # request exists

    context 'request no longer exists' do
      before :each do
        sign_in user = FactoryGirl.create(:user) 
      end

      it 'alerts the user' do
        get :edit, id: 999, user_id: user.id
        expect(flash[:alert]).to eq 'Sorry. The walk no longer exists' 
      end

      it 'notices the record was not found' do
        get :edit, id: 999, user_id: user.id        
        expect(response).to redirect_to jobs_path
      end
    end
  end

  describe 'POST #create' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
      request.env["HTTP_REFERER"] = user_path(@user)
    end

    let(:requested_of_user) { FactoryGirl.create(:user) }
    let(:job) { FactoryGirl.create(:job) }
    let(:request_attr) { FactoryGirl.attributes_for(:request, user_id: @user, requested_of_user_id: requested_of_user, job_id: job) }

    it 'saves the new request in the database' do
      expect{
        post :create, user_id: @user.id, request: request_attr
        }.to change(Request, :count).by(1)
    end

    it 'notifies the requester' do
      post :create, user_id: @user.id, request: request_attr
      expect(flash[:notice]).to eq 'Request sent! Check your dashboard'
    end

    it 'redirects back to the referring page' do
      post :create, user_id: @user.id, request: request_attr
      expect(response).to redirect_to user_path(@user)
    end
  end

  describe 'DELETE #destroy' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      request.env["HTTP_REFERER"] = user_path(@user)
      @walk_request = FactoryGirl.create(:request, user: @user)
    end

    #let(:walk_request) { FactoryGirl.create(:request, user: @user) }

    context 'when record found' do
      it 'deletes the request from the database' do
        # binding.pry
        expect{delete :destroy, user_id: @user.id, id: @walk_request}.to change(Request, :count).by(-1)
      end

      it 'redirects to user dashboard' do
        delete :destroy, user_id: @user.id, id: @walk_request
        expect(response).to redirect_to user_path(@user)
      end  

      it 'notifies the requester' do
        delete :destroy, user_id: @user.id, id: @walk_request
        expect(flash[:alert]).to eq 'Walk cancelled'
      end
    end # when record found 

    context 'when record not found' do


    end # 'when record not found'

  end # destroy

end # RequestsController