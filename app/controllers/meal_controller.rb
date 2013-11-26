class MealController < ApplicationController
  before_action :signed_in_user

  def signed_in_user 
    redirect_to food_search_url unless signed_in?
  end
end
