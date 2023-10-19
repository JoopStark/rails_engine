class Item < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id
  # has_many :invoice_items

  # def self.name_search(name, min_price, max_price)
  #   if [name, min_price, max_price].all?
  #     head 400
  #   elsif name
  #     if min_price || max_price
  #       aldkflaskd
  #     else
  #     end
  #   elsif min_price
  #     if max_price
  #       asdfsdf
  #     else
  #     end
  #   else
  #     head 400
  #   end
  # end

  def self.search(name, min_price, max_price)
    new_name = if name == " " 
                  nil
               else
                  name
               end
    new_min = if min_price 
                min_price 
              else 
                0
              end
    new_max = if max_price 
                max_price 
              else
                1e999
              end

    if [new_name, min_price, max_price].all?
      head 400
    elsif [new_name && min_price].all?
      head 400
    elsif [new_name && max_price].all?
      head 400
    elsif new_name  
      where("name ILIKE ?", "%#{new_name}%")
    else
      where("unit_price > ? AND unit_price < ?", new_min, new_max)
    end
  end

  # def self.search(name, min_price, max_price)
  #   where("name ilike ?", "%#{name}%")
  # end



end
