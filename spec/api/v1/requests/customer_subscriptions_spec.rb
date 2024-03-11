require "rails_helper"

RSpec.describe "customer subscriptions", type: :request do
  let(:customer) { FactoryBot.create(:customer) }
  let(:tea1) { FactoryBot.create(:tea) }
  let(:tea2) { FactoryBot.create(:tea) }
  let(:subscription_params) do
    {
      subscription: {
        title: "Monthly Double Delight",
        price: "19.99",
        status: "active",
        frequency: "monthly",
        tea_ids: [tea1.id, tea2.id]
      }
    }
  end

  def create_subscription(customer, params)
    post "/api/v1/customers/#{customer.id}/subscriptions", params: params
  end

  describe "POST /api/v1/customers/subscriptions" do
    it "activates/adds a customer subscription" do
      create_subscription(customer, subscription_params)
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]["attributes"]["title"]).to eq("Monthly Double Delight")
      expect(json_response["data"]["attributes"]["status"]).to eq("active")
      expect(json_response["included"].first["type"]).to eq("tea")
      expect(json_response["included"].count).to eq(2)
    end
  end

  describe "UPDATE /api/v1/customers/:id/subscriptions/:subscription_id" do
    it "deactivates a customer subscription" do
      create_subscription(customer, subscription_params)
      expect(response).to have_http_status(:created)

      subscription = JSON.parse(response.body)["data"]
      subscription_id = subscription["id"]

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription_id}", params: { subscription: { status: "inactive" } }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response["data"]["attributes"]["status"]).to eq("inactive")
    end

    it "is sad if you try to update a customer subscription status with an empty string" do
      create_subscription(customer, subscription_params)
      expect(response).to have_http_status(:created)

      subscription = JSON.parse(response.body)["data"]
      subscription_id = subscription["id"]

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription_id}", params: { subscription: { status: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /api/v1/customers/:id/subscriptions/" do
    it "returns a list of customer subscriptions, active or not" do
      sub1 = Subscription.create!(title: "Monthly Myst", price: "19.99", status: "active", frequency: "monthly", customer_id: customer.id, tea_ids: [tea1.id, tea2.id])
      sub2 = Subscription.create!(title: "Weekly Herbal", price: "9.99", status: "inactive", frequency: "weekly", customer_id: customer.id, tea_ids: [tea1.id])
      sub3 = Subscription.create!(title: "Bi-Monthly Blast", price: "13.99,", status: "active", frequency: "bi-monthly", customer_id: customer.id, tea_ids: [tea1.id, tea2.id])

      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response["data"].count).to eq(3)
      expect(json_response["data"].first["attributes"]["title"]).to eq("Monthly Myst")

      create_subscription(customer, subscription_params)
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response["data"].count).to eq(4)
    end

    it "returns an empty hash and 404 if no subscriptions exist" do
      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)

      expect(json_response).to eq({})
    end
  end

  describe "GET /api/v1/customers/:id/subscriptions/:subscription_id" do
    it "returns a single customer subscription" do
      create_subscription(customer, subscription_params)

      get "/api/v1/customers/#{customer.id}/subscriptions/#{Subscription.last.id}"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]["attributes"]["title"]).to eq("Monthly Double Delight")
    end

    it "is sad if you try to get a customer subscription that doesn't exist" do
      create_subscription(customer, subscription_params)

      get "/api/v1/customers/#{customer.id}/subscriptions/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({})
    end
  end

  describe "DELETE /api/v1/customers/:id/subscriptions/:subscription_id" do
    it "deletes a customer subscription" do
      create_subscription(customer, subscription_params)

      delete "/api/v1/customers/#{customer.id}/subscriptions/#{Subscription.last.id}"

      expect(response).to have_http_status(:no_content)
    end

    it "is sad if you try to delete a customer subscription that doesn't exist" do
      delete "/api/v1/customers/#{customer.id}/subscriptions/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Subscription not found")
      expect(Subscription.count).to eq(0)
      expect(Customer.count).to eq(1)
      expect(Customer.first.subscriptions.count).to eq(0)
    end
  end
end
