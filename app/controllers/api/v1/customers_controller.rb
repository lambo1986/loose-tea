class Api::V1::CustomersController < ApplicationController
  def subscribe
    customer = Customer.find(params[:id])
    
  end
end
