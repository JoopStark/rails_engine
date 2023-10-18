class Api::V1::ItemsController < Api::V1::ApplicationController
  def index
    render json: ItemSerializer.new(index_argument)
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

  private

  def index_argument
    if params[:merchant_id]
      Merchant.find_by_id(params[:merchant_id]).items
    else
      Item.all
    end
  end
end