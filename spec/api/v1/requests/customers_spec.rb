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

    it "fails to create a new customer if fields are blank" do
      post "/api/v1/customers", params: {
        customer: {
          first_name: "",
          last_name: "",
          email: "",
          address: "",
        }
      }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /customers/:id" do
    it "returns a customer if they exist" do
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

    it "returns an error if the customer does not exist" do
      get "/api/v1/customers/999999999999"
      json_response = JSON.parse(response.body)

      expect(json_response["error"]).to eq("Customer not found")
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Customer not found")
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

  describe "index sad path" do
    it "returns a 404 error if no customers exist" do
      get "/api/v1/customers"

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
    end
  end
end
