class Api::V1::MerchantsController < Api::V1::ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end
  
  def show
    if params[:item_id]
      render_merchant_by_item
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end

  def find
    render json: MerchantSerializer.new(Merchant.name_search(params[:name]))
  end
  
  private

  def render_merchant_by_item
    if is_not_an_integer?(params[:item_id]) #this is superfluous but could give better errors later.
      head 404
    elsif Item.where(id: params[:item_id]).empty?
      head 404
    else
      render json: MerchantSerializer.new(Item.find_by_id(params[:item_id]).merchant)
    end
  end
end