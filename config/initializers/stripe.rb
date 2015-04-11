Rails.configuration.stripe = {
    :publishable_key => "pk_test_OTqGBrtFN2ByG54f1NNZaCq7",
    :secret_key      => "sk_test_96CGDM3AjDMxjRVMqs5RG9rj"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

