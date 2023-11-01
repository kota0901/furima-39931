class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:index, :new, :create]
  before_action :check_owner, only: [:new, :create]

  def index
    
    @order_address = OrderAddress.new
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new(order_params)
  
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
    params.require(:order_address).permit(:post_code, :region_id, :city, :banchi, :building_name, :number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_owner
    if (@item.user_id == current_user.id || @item.order.present? )
      redirect_to root_path
    end
  end

  def pay_item
   Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
   Payjp::Charge.create(
     amount: @item.price,  # 商品の値段
     card: order_params[:token],    # カードトークン
     currency: 'jpy'                 # 通貨の種類（日本円）
   )
 end

end
