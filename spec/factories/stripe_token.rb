FactoryBot.define do
  factory :stripe_token do
    number { '4242424242424242' }
    exp_month { 7 }
    exp_year { 2020 }
    cvc { '314' }
  end

  class StripeToken
    attr_accessor :number, :exp_month, :exp_year, :cvc

    def save!
      @token = Stripe::Token.create({
        card: {
          number: number,
          exp_month: exp_month,
          exp_year: exp_year,
          cvc: cvc,
        },
      })
    end

    def id
      @token.id
    end
  end
end