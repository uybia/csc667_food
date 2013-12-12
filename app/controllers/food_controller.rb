class FoodController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def db_search
    #flash[:query] = search(params[:food_item])
    query = search(params[:food_item])
    redirect_to food_search_results_path(:query => query)
  end

  def results
    #dbq = flash[:query]
    dbq = params[:query]
    @results = Food.where('name ILIKE ?', dbq)
  end

  def info
    @item = Food.find_by_id(params[:id])
  end
 
  def add_to_meal
      meals = Meal.where('user_id = ?', current_user.id)
      specific = meals.where('meal_tag = ?', params[:meal])
      foodrecent = specific.order("date DESC").pluck(:food_id).take(5)
      @recent = Food.where(:id => foodrecent)
      fq = specific.group('food_id').count('food_id')
      fq = fq.keys.take(5)
      @frequent = Food.where(:id => fq)
      aq = meals.group('food_id').count('food_id')
      aq = aq.keys.take(10)
      @all = Food.where(:id => aq).take(10)


#      @recent = specific.order("date DESC").take(5)
#      fq = specific.group('food_id').count('food_id')
#      fq = fq.keys.take(5)
#      @frequent = specific.where(:food_id => fq)
#      aq = meals.group('food_id').count('food_id')
#      aq = aq.keys.take(10)
#      @all = meals.distinct.where(:food_id => aq).take(10)
  end
  
  def add_item
    date = Date.parse(params[:d]).strftime("%F")
    item = Meal.new
    item.user_id = current_user.id
    item.food_id = params[:food_item]
    item.meal_tag = params[:meal]
    item.date = date
    item.save

    redirect_to meal_plan_path(:date => date)
  end
  
  def addmodal
    @item = Food.find_by_id(params[:id])
    render :layout => false
  end

  def item_search
    query = search(params[:food_item])
    @results = Food.where('name ILIKE ?', query)
  end
  
  def create 
    food = Food.create(food_params)
    redirect_to food_nutritional_path(:id => food.id)
  end

  def show
    if (!signed_in?)
      redirect_to signin_path
    end
   @food = Food.new
  end

private
  def food_params
    params.require(:food).permit(:name, :calories, :totalfat, :saturated, :polyunsaturated, :monosaturated, :transfat, :cholesterol, :potassium, :carbs, :fiber, :sugar, :protein)
  end

  def search(query)
    query.gsub(' ', '%')
    query.insert(0, '%')
    query.insert(query.length, '%')
  end  
end
