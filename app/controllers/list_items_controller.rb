class ListItemsController < ApplicationController
  def index
    @items = ListItem.where('list_id = ?', params[:id])  
  end
  
  def create
     if params[:date].present? 
            date = params[:date]
        else
            date = Time.now.strftime("%F")
        end
    @items = ListItem.new(param)
    @items.list_id = params[:id]
    if @items.save
      redirect_to(:back)
    end
    @list = GroceryList.find(params[:id])
    if(@list.update_attributes(params[:date]))
          #  @date = Date.parse(date)
      else
    end
        
  end
  
  def destroy
        @items = ListItem.find( params[:id]).destroy
        redirect_to :back
    end
  private
    
    def param
      params.require(:list_item).permit(:food_id, :quantity, :type)
    end
end