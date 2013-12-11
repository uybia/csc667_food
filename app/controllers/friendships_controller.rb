class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path(current_user.id)
    else
      flash[:notice] = "Unable to add friend."
      redirect_to users_path(current_user.id)
    end
  end

  def destroy
    friendship = Friendship.find_by_friend_id(params[:id])
    friendship.destroy
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends
    date = Time.now.strftime("%F")
    meals = @user.meals.where('date = ? ', date ).group("id")
    @breakfasts = meals.where(meal_tag: "breakfast").group("meal_tag")
    @lunches = meals.where(meal_tag: "lunch")
    @dinners = meals.where(meal_tag: "dinner")

  end
end

