module Moneybird::Resource::Invoice
  class Payment
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      administration_id
      created_at
      credit_invoice_id
      financial_account_id
      financial_mutation_id
      id
      invoice_id
      invoice_type
      payment_date
      payment_transaction_id
      price
      price_base
      updated_at
      user_id
    )
  end
end
