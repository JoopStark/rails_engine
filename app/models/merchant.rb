class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name
  # has_many :invoices
  def self.name_search(name)
    object = where("name ilike ?", "%#{name}%").order(:name).first
    if object
      object
    else
      Merchant.new(id:nil, name: nil)
    end
  end
end