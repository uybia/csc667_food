class MealsController < ApplicationController
  before_action :signed_in_user

  def index
    @user = User.find_by(params[:id]) 
    @meals = @user.meals
    @breakfasts = @meals.where(meal_tag: "breakfast").group("meal_tag")
    @lunches = @meals.where(meal_tag: "lunch")
    @dinners = @meals.where(meal_tag: "dinner")
  end

  def meal_type
    @meals = @user.meals.find_by_meal_tag(params[:meal])
  end

  def signed_in_user 
    redirect_to food_search_url unless signed_in?
  end
end
