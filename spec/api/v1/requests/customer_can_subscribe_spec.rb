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

  before do
    post "/api/v1/customers/#{customer.id}/subscriptions", params: subscription_params
  end

  describe "POST /api/v1/customers/subscriptions" do
    it "activates/adds a customer subscription" do
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]["attributes"]["title"]).to eq("Monthly Double Delight")
      expect(json_response["data"]["attributes"]["status"]).to eq("active")
      expect(json_response["included"].first["type"]).to eq("tea")
      expect(json_response["included"].count).to eq(2)
    end
  end

  describe "DELETE /api/v1/customers/:id/subscriptions/:subscription_id" do
    it "deactivates a customer subscription" do

    end
  end
end
