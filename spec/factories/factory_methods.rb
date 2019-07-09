module Fetch
  module FactoryMethods
    def create_direct_upload(filename:)
      stub_request(:get, /https\:\/\/#{Regexp.escape(ENV['S3_BUCKET_NAME'])}\.s3\.amazonaws\.com.*/)
        .to_return(status: 200, body: "", headers: {})
      checksum = Digest::MD5.base64digest("Testing")
      post rails_direct_uploads_url params: { blob: { filename: filename, content_type: "text/plain", byte_size: 8, checksum: checksum } }
      response.parsed_body
    end
  end
end