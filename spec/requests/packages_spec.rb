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
end
