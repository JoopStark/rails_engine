class Api::V1::ItemsController < Api::V1::ApplicationController
  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Merchant.find_by_id(params[:merchant_id]).items)
    else
      render json: ItemSerializer.new(Item.all)
    end
    # render json: ItemSerializer.new(index_argument)

  end

  def create
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
  end

  def destroy
  end

  # def idex_argument
  #   if params[:merchant_id]
  #     Merchant.find_by_id(params[:merchant_id]).items
  #   else
  #     Item.all
  #   end
  # end
end