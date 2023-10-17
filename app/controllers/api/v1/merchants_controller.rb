class Api::V1::MerchantsController < Api::V1::ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end
  
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end