class ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  private
  def item_params
    
  params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :price, :image, :delivery_fee_payment_id, :region_id, :deadline_id).merge(user_id: current_user.id) 
  end

end
