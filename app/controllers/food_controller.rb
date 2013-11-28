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
    meals = Meal.where('user_id = ?', current_user.id)
      specific = meals.where('meal_tag = ?', params[:meal])
      @recent = specific.order("date DESC").take(5)
      fq = specific.group('food_id').count('food_id')
      fq = fq.keys.take(5)
      @frequent = specific.where(:food_id => fq)
      fq = meals.group('food_id').count('food_id')
      fq = fq.keys.take(10)
      @all = meals.distinct.where(:food_id => fq)
  end
  
  def add_item
    date = Date.parse(params[:d]).strftime("%F")
    item = Meal.new
    item.user_id = current_user.id
    item.food_id = params[:food_item]
    item.meal_tag = params[:meal]
    item.date = date
    item.save

    redirect_to meal_plan_path
  end
  
end
