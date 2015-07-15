require 'rails_helper'

describe JobsController do

  describe 'GET #index' do

    let(:user) { FactoryGirl.create(:user) }
    let(:job1) { FactoryGirl.create(:job, user_id: user.id) }
    let(:job2) { FactoryGirl.create(:job, user_id: user.id + 1) }

    context 'with params[:user_id]' do
      it 'populates an array of jobs belonging to a user' do
        get :index, user_id: user.id
        expect(assigns(:jobs)).to match_array([job1])
      end

      it 'renders the :index template' do
        get :index, user_id: user.id
        expect(response).to render_template :index
      end
    end

    context 'without params[:user_id]' do
      it 'populates an array with all jobs' do
        get :index
        expect(assigns(:jobs)).to match_array([job1, job2])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end 

  describe "GET #show" do

    let(:job) { FactoryGirl.create(:job) }

    it 'assigns the requested job to @job' do
      get :show, id: job
      expect(assigns(:job)).to eq job
    end

    it 'renders the :show template' do
      get :show, id: job
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)      
    end

    context 'with current_user.pups.empty? = true' do
      it 'alerts to create a pup' do
        get :new
        expect(flash[:alert]).to eql('Create a pup to add to your job')
      end

      it 'redirects to new_user_pup_path' do
        get :new
        expect(response).to redirect_to new_user_pup_path(@user)
      end
    end

    context 'with current_user.pups.empty? = false' do
      before :each do
        FactoryGirl.create(:pup, user_id: @user.id)        
      end

      it 'assigns a new job to @job' do
        get :new
        expect(assigns(:job)).to be_a_new(Job)       
      end
    end
  end

  describe 'GET #edit' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)      
    end

    let(:job) { FactoryGirl.create(:job) }

    it 'assigns the requested job to @job' do
      get :edit, id: job
      expect(assigns(:job)).to eq job
    end

    it 'renders the :edit template' do
      get :edit, id: job
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
      @pup = FactoryGirl.create(:pup)        
    end

    context 'with valid attributes' do

      it 'saves the new job in the database' do
        expect{
          post :create, job: FactoryGirl.attributes_for(:job, user_id: @user.id, pup_id: @pup.id)}.to change(Job, :count).by(1)
      end

      it 'redirects to jobs index' do
        post :create, job: FactoryGirl.attributes_for(:job, user_id: @user.id, pup_id: @pup.id)
        expect(response).to redirect_to users_path(@user)
      end

      it 'notifies the user of creation' do
        post :create, job: FactoryGirl.attributes_for(:job, user_id: @user.id, pup_id: @pup.id)
        expect(flash[:notice]). to eql 'Job created'
      end
    end

    context 'with invalid attributes' do

      it 'does not save the new job in the database' do 
        expect{
          post :create, job: FactoryGirl.attributes_for(:invalid_job)}.not_to change(Job, :count)
      end

      it 're-renders the :new template' do
        post :create, job: FactoryGirl.attributes_for(:invalid_job) 
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
      @job = FactoryGirl.create(:job,
        drop_off_time: Time.now + 1.hours,
        drop_off_location: 'Ruby')
    end    

    context 'with valid attributes' do

      it 'locates the requested job' do
        patch :update, id: @job, job: FactoryGirl.attributes_for(:job)
        expect(assigns(:job)).to eq(@job)
      end

      it 'changes @job attributes' do
        patch :update, id: @job,
        job: FactoryGirl.attributes_for(:job, 
          drop_off_time: Time.new(2002, 10, 31),
          drop_off_location: 'Blackfoot')
        @job.reload
        expect(@job.drop_off_time).to eq(Time.new(2002, 10, 31))
        expect(@job.drop_off_location).to eq('Blackfoot')
      end

      it 'redirects to user\'s profile (i.e. dashboard)' do
        patch :update, id: @job, job: FactoryGirl.attributes_for(:job)
        expect(response).to redirect_to users_path(@user)
      end
    end      

    context 'with invalid attributes' do

      it 'does not change the job\'s attributes' do
        patch :update, id: @job,
        job: FactoryGirl.attributes_for(:job, 
          drop_off_time: Time.new(2005, 12, 25),
          drop_off_location: nil)
        @job.reload
        expect(@job.drop_off_time).not_to eq(Time.new(2005, 12, 25))
        expect(@job.drop_off_location).to eq('Ruby')
      end

      it 're-renders the :edit template' do
        patch :update, id: @job,
        job: FactoryGirl.attributes_for(:invalid_job)
        expect(response).to render_template :edit
      end
    end
  end # PATCH #update 

  describe 'DELETE #destroy' do

    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @job = FactoryGirl.create(:job)
    end 
    
    it 'deletes the job from the database' do
      expect{delete :destroy, id: @job}.to change(Job, :count).by(-1)
    end    

    it 'redirects to jobs index' do
      delete :destroy, id: @job
      expect(response).to redirect_to users_path(@user)
    end    
  end # DELETE

end