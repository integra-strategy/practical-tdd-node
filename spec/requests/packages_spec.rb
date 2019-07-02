require 'rails_helper'

RSpec.describe "Fetching packages", type: :request do
  it "returns packages from Stripe" do
    package = create_package(
      name: 'Monthly',
      amount: 123,
      description: ['Some description']
    )

    first_package = fetch_packages.first
    second_package = fetch_packages.second
    expect(first_package.name).to eq(Package::DAILY_DISPLAY_NAME)
    expect(second_package.name).to eq(package.name)
    expect(second_package.amount).to eq(package.amount)
    expect(second_package.description).to eq(package.description)
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
