class FoodController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def db_search
    query = params[:food_item].gsub(' ', '%')
    query.insert(0, '%')
    query.insert(query.length, '%')
    flash[:query] = query
    redirect_to food_search_results_path
  end

  def results
    dbq = flash[:query]
    @results = Food.where('name LIKE ?', dbq)
  end

  def info
    @item = Food.find_by_id(params[:id])
  end
 
  def add_to_meal
    meals = Meal.where('user_id = ?', params[:uid])
    if params[:meal] == "all" then
      @recent = meals.order("date DESC").take(5)
    end
  end
end
