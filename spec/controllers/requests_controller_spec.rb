require 'rails_helper'

describe RequestsController do 

  before :each do
    @requested_of_user = FactoryGirl.create(:user)
    @job = FactoryGirl.create(:job)
  end

  describe 'GET #index' do
    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @request1 = FactoryGirl.create(:request, user_id: @user.id, status: 'approved')
      @request2 = FactoryGirl.create(:request, user_id: @user.id)    
    end

    #     context "params[:status] = 'approved'" do
    #       it 'populates an array of approved requests belonging to a user' do
    #         get :index, user_id: @user.id, status: 'approved'
    #         expect(assigns(:requests)).to match_array([@request1])
    #       end

    #       it 'renders the :index template' do
    #         get :index, user_id: @user.id, status: 'approved'
    #         expect(response).to render_template :index
    #       end
    #     end

    #     context "without params[:status]" do
    #       it 'populates an array of requests belonging to a user' do    
    #         get :index, user_id: @user.id
    #         expect(assigns(:requests)).to match_array([@request1,@request2])
    #       end

    it 'renders the :index template' do
      get :index, user_id: @user.id
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
    end

    it 'assigns the requested request to @request' do
      request = FactoryGirl.create(:request)
      get :show, id: request, user_id: @user.id
      expect(assigns(:request)).to eq request
    end

    it 'renders the :show template' do
      request = FactoryGirl.create(:request)
      get :show, id: request, user_id: @user.id
      expect(response).to render_template :show
    end
  end  

  describe 'GET #new' do
    it 'assigns a new request to @request' do
      sign_in @user = FactoryGirl.create(:user) 
      get :new, id: request, user_id: @user.id
      expect(assigns(:request)).to be_a_new(Request)       
    end
  end

  describe 'GET #edit' do

    before :each do
      @user = FactoryGirl.create(:user)
      @requested_of_user = FactoryGirl.create(:user)
      @my_request = FactoryGirl.create(:request, user_id: @user.id,
        requested_of_user_id: @requested_of_user.id, job_id: @job.id)      
    end

    context 'request exists' do
      it "and redirects to the user's 'approved' page" do
        get :edit, id: @my_request, user_id: @user.id
        expect(response).to redirect_to root_path(@requested_of_user, status:'approved')
      end
    end

    context 'request no longer exists' do
      before :each do
        sign_in @user = FactoryGirl.create(:user)        
      end

      it 'alerts the user' do
        get :edit, id: 999, user_id: @user.id
        expect(flash[:alert]).to eq 'Sorry. The request or job no longer exists'
      end

      it 'notices the record was not found' do
        get :edit, id: 999, user_id: @user.id        
        expect(response).to redirect_to user_requests_path(@user)
      end
    end
  end

  describe 'POST #create' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @request_attr = FactoryGirl.attributes_for(:request, user_id: @user, requested_of_user_id: @requested_of_user, job_id: @job)
      request.env["HTTP_REFERER"] = user_path(@user)
    end

    it 'saves the new request in the database' do
      expect{
        post :create, user_id: @user.id, request: @request_attr
        }.to change(Request, :count).by(1)
    end

    it 'notifies the requester' do
      post :create, user_id: @user.id, request: @request_attr
      expect(flash[:notice]).to eq 'Request sent! Check your dashboard'
    end

    it 'redirects back to the referring page' do
      post :create, user_id: @user.id, request: @request_attr
      expect(response).to redirect_to user_path(@user)
    end
  end

  #   describe 'PATCH #update' do

  #     before :each do
  #       sign_in @user = FactoryGirl.create(:user) 
  #       @walk_request = FactoryGirl.create(:request, status: 'denied')
  #     end

  #     it 'locates the requested request' do
  #       patch :update, user_id: @user.id, id: @walk_request, request: FactoryGirl.attributes_for(:request, user_id: @user)
  #       expect(assigns(:request)).to eq(@walk_request)
  #     end

  #     it 'changes @walk_request attributes' do
  #       patch :update, user_id: @user.id, id: @walk_request,
  #       request: FactoryGirl.attributes_for(:request, 
  #         status: 'whatever', user_id: @user)
  #       @walk_request.reload
  #       expect(@walk_request.status).to eq('whatever')
  #     end

  #     it 'redirects to the user_request root' do
  #       patch :update, user_id: @user.id, id: @walk_request,
  #       request: FactoryGirl.attributes_for(:request, user_id: @user)
  #       expect(response).to redirect_to user_requests_path(@user)
  #     end
  #   end

  describe 'DELETE #destroy' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @walk_request = FactoryGirl.create(:request)
    end

    it 'deletes the request from the database' do
      expect{
        delete :destroy, user_id: @user.id, id: @walk_request,
        request: FactoryGirl.attributes_for(:request, 
          user_id: @user.id)}.to change(Request, :count).by(-1)
    end

    it 'redirects to user dashboard' do
      delete :destroy, user_id: @user.id, id: @walk_request
      expect(response).to redirect_to user_path(@user)
    end  

    it 'notifies the requester' do
      delete :destroy, user_id: @user.id, id: @walk_request
      expect(flash[:alert]).to eq 'Walk cancelled'
    end
  end

end # RequestsController