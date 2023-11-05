require "rails_helper"

describe "Merchant API" do
  it "sends merchant index" do
    # create_list(:merchant, 3)
    load_test_data

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(4)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_an(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "sends a merchant show" do
    load_test_data

    get "/api/v1/merchants/#{@merchant_1.id}"

    expect(response).to be_successful
    # binding.pry

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "sends a merchant find (show) base on search criteria when only one meets the object" do
    load_test_data

    get "/api/v1/merchants/find?name=oki"

    expect(response).to be_successful
    # binding.pry

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "sends a merchant find (show) base on search criteria when many object meet the search" do
    load_test_data

    get "/api/v1/merchants/find?name=i"

    expect(response).to be_successful
    # binding.pry

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "(sad path-merchant#find) sends a merchant find (show) " do
    load_test_data

    get "/api/v1/merchants/find?name=doug"

    expect(response).to be_successful
    # binding.pry

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq (nil)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq (nil)
  end

  it "sends a merchant show from an item" do
    load_test_data

    get "/api/v1/items/#{@item_1_1.id}/merchant"

    expect(response).to be_successful
    # binding.pry

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "(sad path-merchant#show) sends when id is a string" do
    load_test_data

    get "/api/v1/items/bad_id/merchant"

    expect(response).to have_http_status(:not_found)
  end

  it "(sad path-merchant#show) sends error when merchant id does not exist" do
    load_test_data

    get "/api/v1/items/999999/merchant"

    expect(response).to have_http_status(:not_found)
  end

  it "(sad path-merchant#show) sends error when item_id is a string" do
    load_test_data

    get "/api/v1/items/should_be_int/merchant"

    expect(response).to have_http_status(:not_found)
  end
end