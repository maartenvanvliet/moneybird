module Moneybird::Resource
  class Administration
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      id
      name
      language
      currency
      country
      time_zone
    )

    def ledger_accounts
      Moneybird::Service::LedgerAccount.new(@client, id)
    end

    def purchase_invoices
      Moneybird::Service::PurchaseInvoice.new(@client, id)
    end

    def sales_invoices
      Moneybird::Service::SalesInvoice.new(@client, id)
    end

    def recurring_sales_invoices
      Moneybird::Service::RecurringSalesInvoice.new(@client, id)
    end

    def contacts
      Moneybird::Service::Contact.new(@client, id)
    end

    def estimates
      Moneybird::Service::Estimate.new(@client, id)
    end

    def products
      Moneybird::Service::Product.new(@client, id)
    end

    def webhooks
      Moneybird::Service::Webhook.new(@client, id)
    end

    def identities
      Moneybird::Service::Identity.new(@client, id)
    end

    def workflows
      Moneybird::Service::Workflow.new(@client, id)
    end

    def tax_rates
      Moneybird::Service::TaxRate.new(@client, id)
    end

    def financial_accounts
      Moneybird::Service::FinancialAccount.new(@client, id)
    end

    def financial_mutations
      Moneybird::Service::FinancialMutation.new(@client, id)
    end
  end
end
