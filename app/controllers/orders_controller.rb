class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:index, :new, :create]
  before_action :redirect_if_owner, only: [:new, :create]
  before_action :redirect_if_sold, only: [:new, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = Address.new
    @order_form = OrderForm.new
  end

  def create
    @order_address = OrderForm.new(order_params)
  
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:post_code, :region_id, :city, :banchi, :building_name, :number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold
    return unless user_signed_in? && Order.exists?(item_id: @item.id)

    redirect_to root_path
  end

  def redirect_if_owner
    return unless user_signed_in? && current_user == @item.user

    redirect_to root_path
  end
end
