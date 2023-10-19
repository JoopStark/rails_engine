require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should validate_presence_of :name }
  end

  it "can search for name by a piece of the name and get one merchant" do
    load_test_data
    expect(Merchant.name_search("i").name).to eq("Chikage Kuroba")
  end

  it "(sad path) it will send a Merchant object will nil values if a merchant does not match" do
    load_test_data
    expect(Merchant.name_search("aaa").name).to eq(nil)
  end
end