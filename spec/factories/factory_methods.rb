module Fetch
  module FactoryMethods
    def create_direct_upload(filename:)
      stub_request(:get, /https\:\/\/#{Regexp.escape(ENV['S3_BUCKET_NAME'])}\.s3\.amazonaws\.com.*/)
        .to_return(status: 200, body: "", headers: {})
      checksum = Digest::MD5.base64digest("Testing")
      post rails_direct_uploads_url params: { blob: { filename: filename, content_type: "text/plain", byte_size: 8, checksum: checksum } }
      response.parsed_body
    end

    def create_package(name: "Monthly")
      package = {
        id:"prod_FM9tbBxsZc4sk9",
        object:"product",
        active:true,
        attributes:[],
        caption:nil,
        created:1561995495,
        deactivate_on:[],
        description:nil,
        images:[],
        livemode:false,
        metadata:{},
        name: name,
        package_dimensions:nil,
        shippable:nil,
        statement_descriptor:nil,
        type:"service",
        unit_label:nil,
        updated:1561995495,
        url:nil
      }
      stub_request(:get, "https://api.stripe.com/v1/plans?limit=10")
        .to_return(status: 200, body: {
          data: [package]
          }.to_json)
      stub_request(:get, "https://api.stripe.com/v1/plans/#{package[:id]}")
        .to_return(status: 200, body: package.to_json)
      OpenStruct.new(package)
    end
  end
end