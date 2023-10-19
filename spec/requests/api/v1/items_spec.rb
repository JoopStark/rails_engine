require "rails_helper"

describe "Items API" do
  it "sends items index" do
    # create_list(:merchant, 3)
    load_test_data

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(12)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "sends items index from merchant id" do
    load_test_data

    get "/api/v1/merchants/#{@merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(12)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "(sad path- items#index(by merchant)) cannot send index with bad id" do
    load_test_data

    get "/api/v1/merchants/99999999/items"

    expect(response).to have_http_status("404")
  end

  it "(sad path- items#index(by merchant)) cannot send index with string as id" do
    load_test_data

    get "/api/v1/merchants/bad_lookup/items"

    expect(response).to have_http_status("404")
  end

  it "send an item show" do
    load_test_data

    get "/api/v1/items/#{@item_1_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_an(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_an(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_an(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it "can create for item" do
    load_test_data
    item_params = ({
      "name": "can",
      "description": "just a can",
      "unit_price": "12.1",
      "merchant_id": @merchant_1.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}
  
    post "/api/v1/items", headers: headers, params: JSON.generate({item: item_params})

    created_item = Item.last
  
    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price].to_f)
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "(sad path-item#create) will not create if missing name" do
    load_test_data
    item_params = ({
      "description": "just a can",
      "unit_price": "12.1",
      "merchant_id": @merchant_1.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}
  
    post "/api/v1/items", headers: headers, params: JSON.generate({item: item_params})
  
    expect(response).to have_http_status("401")
  end
  

  it "can destroy for an item" do
    load_test_data
    expect(Item.all.count).to eq(12)
    
    delete "/api/v1/items/#{@item_1_1.id}"
    
    expect(Item.all.count).to eq(11)
  end

  it "can update a item" do 
    load_test_data

    expect(@item_1_1.name).to eq("Portable Bento Box Fax")

    item_params = ({
      "name": "Lunch box"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    put "/api/v1/items/#{@item_1_1.id}", headers: headers, params: JSON.generate({item: item_params})
    
    data = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    expect(data[:data][:attributes][:name]).to eq("Lunch box")
  end

  xit "(sad path - item#create) cannot update with bad id" do 
    load_test_data

    item_params = ({
      "name": "Lunch box"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    put "/api/v1/items/9999999999", headers: headers, params: JSON.generate({item: item_params})
    
    data = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to have_http_status("404")
  end

  it "can find all items by name" do
    load_test_data

    get '/api/v1/items/find_all?name=box'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(7)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can find all items by min_price" do
    load_test_data

    get '/api/v1/items/find_all?min_price=2'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(7)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can find all items by max_price" do
    load_test_data

    get '/api/v1/items/find_all?max_price=2'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can find all items by max_price and min_price" do
    load_test_data

    get '/api/v1/items/find_all?max_price=8&min_price=6'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(2)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "(sad_path items#find_all)cannot search name and price restriction at the same time" do
    load_test_data

    get '/api/v1/items/find_all?max_price=8&name=a'

    expect(response).to have_http_status("400")
  end

  it "(sad_path items#find_all)cannot search negative values" do
    load_test_data

    get '/api/v1/items/find_all?max_price=-8'

    expect(response).to have_http_status("400")
  end

  it "(sad_path items#find_all)cannot not search" do
    load_test_data

    get '/api/v1/items/find_all?'

    expect(response).to have_http_status("400")
  end

end