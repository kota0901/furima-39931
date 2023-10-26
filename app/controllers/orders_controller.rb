class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:new, :create]
  before_action :redirect_if_owner, only: [:new, :create]
  before_action :redirect_if_sold, only: [:new, :create]


  def new
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_form_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )

      @order_form.save
      redirect_to root_path
    else
      render 'new'
    end
  end


  private

  def order_form_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :phone_number, :street_address, :building_name).merge(
      user_id: current_user.id, item_id: params[:id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold
    return unless user_signed_in? && PurchaseHistory.exists?(item_id: @item.id)

    redirect_to root_path
  end

  def redirect_if_owner
    return unless user_signed_in? && current_user == @item.user

    redirect_to root_path
  end

end
