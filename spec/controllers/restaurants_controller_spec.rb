require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do

  context 'uploading an image' do

    login_user

    before :each do
        get :new
    end

    it 'successfully creates a restaurant' do
      expect do
        post :create, restaurant: FactoryGirl.attributes_for(:restaurant_params)
      end.to change(Restaurant, :count).by(1)

    end

  end

end
