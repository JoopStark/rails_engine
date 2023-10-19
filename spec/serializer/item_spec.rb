require 'rails_helper'

describe "Item Serializer" do
  it "can serialize an item" do
    load_test_data

    expect(ItemSerializer.new(Item.find(@item_2_1.id))).to be_an ItemSerializer
  end

  it "it can serialize many items" do
    load_test_data

    expect(ItemSerializer.new(Item.all)).to be_an ItemSerializer
  end
end