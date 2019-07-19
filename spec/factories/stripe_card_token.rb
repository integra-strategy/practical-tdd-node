FactoryBot.define do
  factory :stripe_card_token do
    number { '4242424242424242' }
    exp_month { Time.zone.now.month + 1 }
    exp_year { Time.zone.now.year + 1 }
    cvc { '314' }
  end

  class StripeCardToken
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