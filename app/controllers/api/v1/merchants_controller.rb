class Api::V1::MerchantsController < Api::V1::ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end
  
  def show
      render json: MerchantSerializer.new(show_argument)
  end
  
  private

  def show_argument
    if params[:item_id]
      Item.find_by_id(params[:item_id]).merchant
    else
      Merchant.find(params[:id])
    end
  end
  
end