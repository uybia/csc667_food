class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all
  end

  def show
    date = Time.now.strftime("%F")
    @user = User.find(current_user.id)
    meals = @user.meals.where('date = ? ', date ).group("id")
    @breakfasts = @meals.where(meal_tag: "breakfast").group("meal_tag")
    @lunches = @meals.where(meal_tag: "lunch")
    @dinners = @meals.where(meal_tag: "dinner") 
  end

  def index
   @users = User.where('id <> ?', current_user.id)
   @friends = current_user.friends
  end

  def new
    @user = User.new
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      Goal.create(:user_id => @user.id, :calories => 2000)
      redirect_to root_path 
    else
      render 'new'
    end
  end

   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
