class GoalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
   render :layout => false
  end

  def update
    goal = Goal.find_by_user_id(current_user.id)
    goal.update(:calories => params[:calorie_goal])

    redirect_to user_path(current_user.id)
  end
end
