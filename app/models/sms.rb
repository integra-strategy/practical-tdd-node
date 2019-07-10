class Sms
  def send_sms(args)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client.api.account.messages.create(
      args.merge(from: ENV['TWILIO_PHONE_NUMBER'])
    )
  end
end