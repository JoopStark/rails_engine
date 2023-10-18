class Api::V1::ItemsController < Api::V1::ApplicationController
  def index
    render json: ItemSerializer.new(index_argument)
  end

  def create
    item = Item.create(item_params)
    if item.save
      response.body = ItemSerializer.new(item)
      head 201
    else
      # error message
      head 401
    end

  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
  end

  def destroy
    Item.find(params[:id])
        .destroy
  end

  private

  def index_argument
    if params[:merchant_id]
      Merchant.find_by_id(params[:merchant_id]).items
    else
      Item.all
    end
  end

  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
end