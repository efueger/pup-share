require 'rails_helper'

describe AvailabilitiesController do

  describe 'GET #index' do
    it 'populates an array with all availabilities' do
      user        = FactoryGirl.create(:user)
      lunch       = FactoryGirl.create(:availability, user_id: user.id)
      after_work  = FactoryGirl.create(:availability, user_id: user.id + 1)
      get :index
      expect(assigns(:availabilities)).to match_array([lunch, after_work])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end


  describe "GET #show" do
    it 'assigns the requested availability to @availability' do
      availability = FactoryGirl.create(:availability)
      get :show, id: availability
      expect(assigns(:availability)).to eq availability
    end

    it 'renders the :show template' do
      availability = FactoryGirl.create(:availability)
      get :show, id: availability
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it 'assigns a new availability to @availability' do
      get :new
      expect(assigns(:availability)).to be_a_new(Availability)
    end

    it 'renders the :new template' do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it 'assigns the requested availability to @availability' do
      lunch = FactoryGirl.create(:availability)
      get :edit, id: lunch
      expect(assigns(:availability)).to eq lunch
    end

    it 'renders the :edit template' do
      lunch = FactoryGirl.create(:availability)
      get :edit, id: lunch
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)      
    end

    context 'with valid attributes' do
      it 'saves the new availability in the database' do
        expect{
          post :create, availability: FactoryGirl.attributes_for(:availability)}.to change(Availability, :count).by(1)
      end

      it 'redirects to availabilities#show' do
        post :create, availability: FactoryGirl.attributes_for(:availability)
        expect(response).to redirect_to user_availabilities_path(@user)
      end

      it 'notifies the user of creation' do
        post :create, availability: FactoryGirl.attributes_for(:availability)
        expect(flash[:notice]). to eql 'Availability created'
      end

    end

    context 'with invalid attributes' do
      it 'does not save the new availability in the database' do 
        expect{
          post :create, availability: FactoryGirl.attributes_for(:invalid_availability)}.not_to change(Availability, :count)     
      end

      it 're-renders the :new template' do
        post :create, availability: FactoryGirl.attributes_for(:invalid_availability)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    before :each do
      sign_in @user = FactoryGirl.create(:user)
      @availability = FactoryGirl.create(:availability,
        available_to: Time.now + 1.hours,
        location: 'Dawson')
    end

    context 'with valid attributes' do
      it 'locates the requested availability' do
        patch :update, id: @availability, availability: FactoryGirl.attributes_for(:availability)
        expect(assigns(:availability)).to eq(@availability)
      end

      it 'changes @availability attributes' do
        patch :update, id: @availability,
        availability: FactoryGirl.attributes_for(:availability, 
          available_to: Time.new(2002, 10, 31),
          location: 'Blackfoot')
        @availability.reload
        expect(@availability.available_to).to eq(Time.new(2002, 10, 31))
        expect(@availability.location).to eq('Blackfoot')
      end

      it 'redirects to the updated availability' do
        patch :update, id: @availability, availability: FactoryGirl.attributes_for(:availability)
        expect(response).to redirect_to user_availabilities_path(@user)
      end
    end

    context 'with invalid attributes' do
      it "does not change the availability's attributes" do
        patch :update, id: @availability,
        availability: FactoryGirl.attributes_for(:availability, 
          available_to: Time.new(2005, 12, 25),
          location: nil)
        @availability.reload
        expect(@availability.available_to).not_to eq(Time.new(2005, 12, 25))
        expect(@availability.location).to eq('Dawson')
      end
      it 're-renders the :edit template' do
        patch :update, id: @availability,
        availability: FactoryGirl.attributes_for(:invalid_availability)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      sign_in @user = FactoryGirl.create(:user) 
      @availability = FactoryGirl.create(:availability)
    end

    it 'deletes the availability from the database' do
      expect{
        delete :destroy, id: @availability,
        availability: FactoryGirl.attributes_for(:availability, 
          user_id: @user.id)}.to change(Availability, :count).by(-1)
    end

    it 'redirects to user_availabilites#index' do
      delete :destroy, id: @availability
      expect(response).to redirect_to user_availabilities_path(@user)
    end
  end

end
