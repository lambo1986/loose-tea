class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions

    if subscriptions.present?
      render json: SubscriptionSerializer.new(subscriptions).serializable_hash.to_json, status: 200
    else
      render json: {}, status: 404
    end
  end

  def show
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.find_by(id: params[:id])

    if subscription.present?
      render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :ok
    else
      render json: {}, status: 404
    end
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(subscription_params)

    if subscription.persisted?
        params[:subscription][:tea_ids].each do |tea_id|
        subscription.teas << Tea.find(tea_id)
      end
        render json: SubscriptionSerializer.new(subscription, include: [:teas]).serializable_hash.to_json, status: :created
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

  def destroy
    subscription = Subscription.find_by(id: params[:id])

    if subscription
      subscription.destroy
      render json: {}, status: :no_content
    else
      render json: { error: 'Subscription not found' }, status: :not_found
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end
