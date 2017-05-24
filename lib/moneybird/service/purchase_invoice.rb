module Moneybird::Service
  class PurchaseInvoice
    include Moneybird::Traits::AdministrationService
    include Moneybird::Traits::Service
    include Moneybird::Traits::Find
    include Moneybird::Traits::FindAll
    include Moneybird::Traits::Save
    include Moneybird::Traits::Delete

    def resource_class
      Moneybird::Resource::PurchaseInvoice
    end

    def path
      "#{administration_id}/documents/purchase_invoices"
    end
  end
end
