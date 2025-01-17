# Handle a Paypal IPN event with 'txn_type' = 'recurring_payment_skipped'
class Payments::Paypal::Subscription::HandleRecurringPaymentSkipped
  include Mandate

  initialize_with :payload

  def call
    subscription = Payments::Subscription.find_by(external_id:, provider: :paypal)
    return unless subscription

    Payments::Subscription::Overdue.(subscription)
  end

  private
  def external_id = payload["recurring_payment_id"]
end
