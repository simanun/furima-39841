class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_address = PurchaseAddress.new
    @item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id != @item.user_id && @item.sold_out?
      redirect_to root_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    @item = Item.find(params[:item_id])
    amount = @item.price
    if @purchase_address.valid?
      pay_item(amount)
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(
      :post_code,
      :prefecture_id,
      :city,
      :town_number,
      :building_name,
      :telephone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item(amount)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount:,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
