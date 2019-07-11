class Sms
  attr_accessor :errors

  def initialize
    @errors = []
  end

  def send_sms(args)
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client.api.account.messages.create(
      args.merge(from: ENV['TWILIO_PHONE_NUMBER'])
    )
  rescue Twilio::REST::RestError => e
    Rails.logger.debug("Twilio request failure. Error on next line.")
    Rails.logger.debug(e.backtrace)
    @errors << { path: 'checkIn', message: 'There was a problem checking-in. Please see an employee.' }
  end

  def successful?
    errors.empty?
  end
end