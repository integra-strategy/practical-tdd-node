module Fetch
  module FactoryMethods
    def create_direct_upload(filename:)
      stub_request(:get, /https\:\/\/#{Regexp.escape(ENV['S3_BUCKET_NAME'])}\.s3\.amazonaws\.com.*/)
        .to_return(status: 200, body: "", headers: {})
      checksum = Digest::MD5.base64digest("Testing")
      post rails_direct_uploads_url params: { blob: { filename: filename, content_type: "text/plain", byte_size: 8, checksum: checksum } }
      response.parsed_body
    end

    def create_package(name: "Monthly", amount: 123, description: ['Some description'])
      plan = {
        id: "plan_FM9EGLCjwDi8BR",
        object: "plan",
        active: true,
        aggregate_usage: nil,
        amount: 999,
        billing_scheme: "per_unit",
        created: 1561993020,
        currency: "usd",
        interval: "month",
        interval_count: 1,
        livemode: false,
        metadata: { display_name: name, description: description.to_json },
        nickname: "Monthly",
        product: "prod_FM9E16ipXznuxG",
        tiers: nil,
        tiers_mode: nil,
        transform_usage: nil,
        trial_period_days: nil,
        usage_type: "licensed"
      }
      stub_request(:get, "https://api.stripe.com/v1/plans?limit=10")
        .to_return(status: 200, body: {
          data: [plan]
          }.to_json)
      stub_request(:get, "https://api.stripe.com/v1/plans/#{plan[:id]}")
        .to_return(status: 200, body: plan.to_json)
      Package.new(plan)
    end
  end
end