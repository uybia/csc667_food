class CalendarController < ApplicationController

  def show 
    @meals = Meal.where("strftime('%Y', date) = ? AND strftime('%m', date) = ?", params[:year], params[:month])
   render :json => @meals.to_json(:include  => :food)
  end

  def index
  end

end
