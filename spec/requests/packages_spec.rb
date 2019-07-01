require 'rails_helper'

RSpec.describe "Fetching packages", type: :request do
  it "returns packages from Stripe" do
    package = create_package(name: 'Monthly')
    result = fetch_packages.first

    expect(result.name).to eq(package.name)
  end

  def fetch_packages
    fetch_packages_query = <<~GQL
      query Packages {
        packages {
          name
        }
      }
    GQL
    graphql(query: fetch_packages_query, variables: OpenStruct.new).data.packages
  end

  def create_package(name:)
    package = {
      "id"=>"prod_FM9tbBxsZc4sk9",
      "object"=>"product",
      "active"=>true,
      "attributes"=>[],
      "caption"=>nil,
      "created"=>1561995495,
      "deactivate_on"=>[],
      "description"=>nil,
      "images"=>[],
      "livemode"=>false,
      "metadata"=>{},
      "name"=> name,
      "package_dimensions"=>nil,
      "shippable"=>nil,
      "statement_descriptor"=>nil,
      "type"=>"service",
      "unit_label"=>nil,
      "updated"=>1561995495,
      "url"=>nil
    }
    stub_request(:get, "https://api.stripe.com/v1/products?limit=10")
      .to_return(status: 200, body: {
        data: [package]
        }.to_json)
    OpenStruct.new(package)
  end
end
