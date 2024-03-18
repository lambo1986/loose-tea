class Api::V1::CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    customers = Customer.all
    if customers.present?
      render json: CustomerSerializer.new(customers).serializable_hash.to_json
    else
      render json: { error: "No customers found" }, status: 404
    end
  end


  def show
    customer = Customer.find(params[:id])
    render json: CustomerSerializer.new(customer).serializable_hash.to_json
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer, status: :created
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end

  def record_not_found
    render json: { error: "Customer not found" }, status: :not_found
  end
end
