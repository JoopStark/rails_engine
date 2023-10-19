class Api::V1::ItemsController < Api::V1::ApplicationController
  def index
    if params[:merchant_id]
      render_item_by_merchant
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def create
    item = Item.create(item_params)
    if item.save
      head 201
      response.body = ItemSerializer.new(Item.last).to_json
    else
      head 401
      # error message
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
    # response.body = ItemSerializer.new(Item.find(params[:id])).to_json
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      head 201
      response.body = ItemSerializer.new(Item.find(item.id)).to_json
    else
      head 404
    end
  end

  def destroy
    Item.find(params[:id])
        .destroy
  end

  def find_all
    if (new_name && params[:min_price] || 
                    params[:max_price])
      head 400
    elsif (params[:min_price]&.to_i&.negative? ||
          params[:max_price]&.to_i&.negative?)
      head 400
    elsif new_name  
      render json: ItemSerializer.new(Item.where("name ILIKE ?", "%#{new_name}%"))
    elsif (params[:min_price] || params[:min_price])
      render json: ItemSerializer.new(Item.where("unit_price > ? AND unit_price < ?", new_min, new_max))
    else
      head 400
    end
  end

  private

  def index_argument
    if params[:merchant_id]
      Merchant.find_by_id(params[:merchant_id]).items
    else
      Item.all
    end
  end

  def render_item_by_merchant
    if Merchant.where(id: params[:merchant_id]).empty?
      head 404
    elsif is_not_an_integer?(params[:merchant_id])
      head 404
    else
      render json: ItemSerializer.new(Merchant.find_by_id(params[:merchant_id]).items)
    end
  end

  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
  
  def new_name
    if params[:name] == "" 
      nil
    else
      params[:name]
    end
  end

  def new_min 
    if params[:min_price] 
      params[:min_price] 
    else 
      0
    end
  end

  def new_max
    if params[:max_price] 
      params[:max_price] 
    else
      1e999
    end
  end
end