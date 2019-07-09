require 'rails_helper'

RSpec.describe "Fetching packages", type: :request do
  it "returns packages from Stripe" do
    package = create(
      :stripe_plan,
      name: 'Monthly',
      amount: 123,
      description: ['Some description']
    )

    result = fetch_packages.first

    expect(result.name).to eq(package.name)
    expect(result.amount).to eq(package.amount)
    expect(result.description).to eq(package.description)
  end

  def fetch_packages
    fetch_packages_query = <<~GQL
      query Packages {
        packages {
          name
          amount
          description
        }
      }
    GQL
    graphql(query: fetch_packages_query, variables: OpenStruct.new).data.packages
  end
end
