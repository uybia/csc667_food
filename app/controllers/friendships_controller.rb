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
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends
  end
end
