require 'rails_helper'

RSpec.describe "Fetching activity list", type: :request do
  it "returns the check-ins for the specified park", :focus do
    stub_sms
    park_a = create(:park)
    member = create(:member, :with_phone_number, park: park_a, create_subscription: true)
    send_verification_code(member)
    submit_verification_code(member)

    result = fetch_activity_list(park: park_a, type: 'check_in')

    expect(result.count).to eq(1)
    expect(result.items.first.user.id).to eq(member.id.to_s)
    expect(result.items.first.user.time).to eq(Time.zone.now.iso8601)
  end

  def fetch_activity_list(park:, type:)
    query = <<~GQL
      query FetchActivityList($parkId: ID!, $type: Activity!) {
        fetchActivityList(parkId: $parkId, type: $type) {
          items {
            user {
              id
              activityTime
            }
          }
          count
        }
      }
    GQL
    graphql(
      query: query,
      variables: OpenStruct.new(
        park_id: park.id,
        type: type
      )
    ).data.fetch_activity_list
  end
end