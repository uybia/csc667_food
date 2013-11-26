class MealsController < ApplicationController
  before_action :signed_in_user

  def index
    @user = User.find_by(params[:id]) 
    @meals = @user.meals
  end

  def signed_in_user 
    redirect_to food_search_url unless signed_in?
  end
end
