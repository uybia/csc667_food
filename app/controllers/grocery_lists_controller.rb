class GroceryListsController < ApplicationController
    before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
    def index
        if params[:date].present? 
            date = params[:date]
        else
            date = Time.now.strftime("%F")
        end
        @lists = GroceryList.where("user_id = ?", current_user.id)
        @list = GroceryList.new
        @date = Date.parse(date)
        @items = ListItem.find_all_by_list_id(params[:id])  
    end
    
    def show
        if params[:date].present? 
            date = params[:date]
        else
            date = Time.now.strftime("%F")
        end
        @list = GroceryList.find(params[:id])
        @items = ListItem.new
        @item = ListItem.where('list_id = ?', params[:id])
        
    end
    
    def new
        @list = GroceryList.new
    end
    
    def create
      #  if params[:date].present?
      #      date = params[:date]
      #  else
      #      date = Time.now.strftime("%F")
      #  end
        @list = GroceryList.new(param)
        
        @list.user_id = (current_user.id)
       # @date = Date.parse(date)
        #@list.date = Date.parse(date)
        if @list.save
            redirect_to @list
        else
            #render 'index'
        end
    end
    
    def destroy
        @list = GroceryList.find(params[:id]).destroy
        redirect_to :back
    end
    
    private
    
    def param
      params.require(:grocery_list).permit(:list_id, :date)
    end

end
