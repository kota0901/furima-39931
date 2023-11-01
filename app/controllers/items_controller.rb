class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]

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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
      
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    
  params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :price, :image, :delivery_fee_payment_id, :region_id, :deadline_id).merge(user_id: current_user.id) 
  end

  def set_item
    @item = Item.find(params[:id])
  end  

  def redirect_unless_owner
    unless current_user == @item.user
      redirect_to root_path
    end
  end

end
