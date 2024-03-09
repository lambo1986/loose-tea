require "rails_helper"

RSpec.describe "customer subscriptions", type: :request do
  describe "POST /api/v1/customers/subscribe" do
    it "creates a customer subscription" do
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

      post "/api/v1/customers/#{customer.id}/subscribe", params: subscription_params

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response["subscription"]["title"]).to eq("Monthly Delight")
      expect(json_response["teas"].count).to eq(2)
    end
  end
end