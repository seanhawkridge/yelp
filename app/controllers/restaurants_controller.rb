class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :create]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.owned_by?(current_user)
      @restaurant.update(restaurant_params)
    else
      flash[:notice] = 'Sorry - you can only edit your own posts'
    end
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.owned_by?(current_user)
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = 'Sorry - you can only delete your own posts'
    end
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :image).merge(user: current_user)
  end

end
