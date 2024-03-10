class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(subscription_params)

    if subscription.persisted?
      params[:subscription][:tea_ids].each do |tea_id|
        subscription.teas << Tea.find(tea_id)
      end
      render json: SubscriptionSerializer.new(subscription, include: [:teas]).serializable_hash, status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    
    if subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :ok
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end
