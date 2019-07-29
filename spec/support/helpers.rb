module Fetch
  module Helpers
    def stub_sms(status: 200)
      stub_twilio_request.to_return(status: status, body: "", headers: {})
    end
  
    def stub_twilio_request
      stub_request(:post, "#{ENV['TWILIO_API_URL']}/Messages.json").
        with(
          body: { "Body"=> nil, "From"=> ENV['TWILIO_PHONE_NUMBER'], "To"=>/\d+/ },
        )
    end
  end
end