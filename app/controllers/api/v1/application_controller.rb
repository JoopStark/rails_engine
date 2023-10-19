class Api::V1::ApplicationController < ApplicationController
  def is_not_an_integer?(object)
    object.to_i.to_s != object
  end
end