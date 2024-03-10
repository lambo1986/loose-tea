require "rails_helper"

RSpec.describe "customer subscriptions", type: :request do
  describe "POST /api/v1/customers/subscriptions" do
    it "activates/adds a customer subscription" do
      customer = FactoryBot.create(:customer)
      tea1 = FactoryBot.create(:tea)
      tea2 = FactoryBot.create(:tea)
      subscription_params = {
        subscription: {
          title: "Monthly Double Delight",
          price: "19.99",
          status: "active",
          frequency: "monthly",
          tea_ids: [tea1.id, tea2.id]
        }
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", params: subscription_params

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]["attributes"]["title"]).to eq("Monthly Double Delight")
      expect(json_response["data"]["attributes"]["status"]).to eq("active")
      expect(json_response["included"].count).to eq(2)
    end
  end

  describe "DELETE /api/v1/customers/:id/subscriptions/:subscription_id" do

  end
end
