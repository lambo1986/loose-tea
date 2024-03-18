require "rails_helper"

RSpec.describe "customer controller actions", type: :request do
  describe "POST /customers" do
    it "creates a new customer" do
      post "/api/v1/customers", params: {
        customer: {
          first_name: "Jeffrey",
          last_name: "Willscott",
          email: "cooldude@freebird.com",
          address: "134234 Hwy 123 Eureke, NV 12345",
        }
      }

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)

      expect(json_response["first_name"]).to eq("Jeffrey")
      expect(json_response["last_name"]).to eq("Willscott")
      expect(Customer.last.email).to eq("cooldude@freebird.com")
    end
  end

  describe "GET /customers/:id" do
    it "returns a customer" do
      post "/api/v1/customers", params: {
      customer: {
        first_name: "Jeffrey",
        last_name: "Willscott",
        email: "cooldude@freebird.com",
        address: "134234 Hwy 123 Eureke, NV 12345",
      }
    }

      expect(response).to have_http_status(:created)

      get "/api/v1/customers/#{Customer.last.id}"

      json_response = JSON.parse(response.body)

      expect(json_response["first_name"]).to eq("Jeffrey")
    end
  end

  describe "GET /api/v1/customers" do
    before do
      create_list(:customer, 5)
      get "/api/v1/customers"
    end

    it "returns all customers" do
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(5)
      expect(json_response.first).to include("first_name")
    end
  end
end
