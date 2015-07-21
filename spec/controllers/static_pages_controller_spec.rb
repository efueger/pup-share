require 'rails_helper'

describe StaticPagesController do

  describe 'renders like nobodys bizness' do
    it 'renders :index' do
      get :index
      expect(response).to render_template :index
    end

    it 'renders :about' do
      get :about
      expect(response).to render_template :about
    end

    it 'renders :terms_of_service' do
      get :terms_of_service
      expect(response).to render_template :terms_of_service
    end

    it 'render :privacy_policy' do
      get :privacy_policy
      expect(response).to render_template :privacy_policy  
    end
  end

end