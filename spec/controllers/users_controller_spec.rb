require 'rails_helper'

describe UsersController do

#   describe 'GET #index' do
#     let(:user1) { FactoryGirl.create(:user) }
#     let(:user2) { FactoryGirl.create(:user) }

#     it 'populates an array with all jobs' do
#       get :index
#       expect(assigns(:users)).to match_array([user1, user2])
#     end

#     it 'renders the :index template' do
#       get :index
#       expect(response).to render_template :index   
#     end
#   end # 'GET #index'

  describe 'GET #show' do

    let(:user)   { FactoryGirl.create(:user) }
    let(:ace)    { FactoryGirl.create(:pup, user_id: user.id) }
    let(:dog)    { FactoryGirl.create(:pup, user_id: user.id) }
    let(:lunch)  { FactoryGirl.create(:availability, user_id: user.id) }
    let(:bfast)  { FactoryGirl.create(:availability, user_id: user.id) }
    let(:job1)   { FactoryGirl.create(:job, user_id: user.id) }
    let(:job2)   { FactoryGirl.create(:job, user_id: user.id) }

    before :each do
      sign_in user
    end

    it 'assigns all of a user\'s pups to to @pups' do
      get :show, id: user   
      expect(assigns(:pups)).to eq user.pups
    end

#     it 'assigns all of a user\'s availabilities to @availabilities' do
#       get :show, id: user
#       expect(assigns(:availabilities)).to eq user.availabilities
#     end

#     it 'assigns all of a user\'s jobs to to @jobs' do
#       get :show, id: user
#       expect(assigns(:jobs)).to eq user.jobs
#     end

    it 'renders the :show template' do
      get :show, id: user
      expect(response).to render_template :show
    end
  end # 'GET #show'

  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)       
    end
  end # 'GET #new'

  describe 'GET #edit' do

    let(:user) { FactoryGirl.create(:user) }      

    it 'assigns the requested user to @user' do
      sign_in user
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    it 'renders the :edit template' do
      get :edit, id: user
      expect(response).to render_template :edit
    end
  end # 'GET #edit'


  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect{ post :create, user: FactoryGirl.attributes_for(:user)}.to change(User, :count).by(1)
      end

      it 'redirects to user profile' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to users_path(@user)
      end

      it 'notifies the user of creation' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(flash[:notice]). to eql 'User created'
      end

    end # with valid attributes

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect{ post :create, user: FactoryGirl.attributes_for(:invalid_user)}.not_to change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end # with invalid attributes
  end # 'POST #create'

  describe 'PATCH #update' do

    let(:user) { FactoryGirl.create(:user, 
      first_name: 'Brent',
      last_name:  'Sullivan') }

    before :each do
      sign_in user
    end

    context 'with valid attributes' do
      it 'locates the requested user' do
        patch :update, id: user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to user_path(user)
      end

      it 'changes user attributes' do
        patch :update, id: user, user: FactoryGirl.attributes_for(:user, first_name: 'Drew')
        user.reload
        expect(user.first_name).to eq ('Drew')
      end

      it 'redirects to user\'s profile (i.e. dashboard)' do
        patch :update, id: user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to user_path(user)
      end
    end # 'with valid attributes'

    context 'with invalid attributes' do

      it 'does not change the user\'s attributes' do
        patch :update, id: user, user: FactoryGirl.attributes_for(:user, first_name: 'Drew', password: nil)
        user.reload
        expect(user.first_name).not_to eq ('Drew')
      end

      it 're-renders the :edit template' do
        patch :update, id: user, user: FactoryGirl.attributes_for(:user, first_name: 'Drew', password: nil)
        expect(response).to render_template :edit
      end
    end # 'with invalid attributes'
  end # 'PATCH #update'

  describe 'DELETE #destroy' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
    end

    it 'deletes the job from the database' do
      expect{
        delete :destroy, id: @user,
        job: FactoryGirl.attributes_for(:user, 
          user_id: @user.id)}.to change(User, :count).by(-1)      
    end

    it 'redirects to user index' do
      delete :destroy, id: @user
      expect(response).to redirect_to root_path
    end

  end # 'DELETE #destroy'

end # UsersController