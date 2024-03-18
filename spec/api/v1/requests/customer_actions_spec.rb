require "rails_helper"

RSpec.describe "customer controller actions", type: :request do
  describe "POST /customers" do
    it "creates a new customer" do
      post "/api/v1/customers", params: {
        first_name: "Jeffrey",
        last_name: "Willscott",
        email: "cooldude@freebird.com",
        address: "134234 Hwy 123 Eureke, NV 12345",
    }

    expect(response).to have_http_status(:created)

    json_response = JSON.parse(response.body)

    expect(json_response["first_name"]).to eq("Jeffrey")
    expect(json_response["last_name"]).to eq("Willscott")
    end
  end
end
