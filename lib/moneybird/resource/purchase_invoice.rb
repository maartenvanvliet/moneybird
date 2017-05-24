module Moneybird::Resource
  class PurchaseInvoice
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      administration_id
      attachments
      contact
      contact_id
      created_at
      currency
      date
      details
      due_date
      entry_number
      events
      exchange_rate
      id
      notes
      origin
      paid_at
      payments
      prices_are_incl_tax
      reference
      revenue_invoice
      state
      tax_number
      total_price_excl_tax
      total_price_excl_tax_base
      total_price_incl_tax
      total_price_incl_tax_base
      updated_at
    )

    def notes=(notes)
      @notes ||= notes.map{ |note| Moneybird::Resource::Generic::Note.build(note) }
    end

    def contact=(attributes)
      @contact = Moneybird::Resource::Contact.build(attributes)
    end

    def details=(line_items)
      @details = line_items.map{ |line_item| Moneybird::Resource::Invoice::Details.build(line_item) }
    end

    def events=(events)
      @events ||= events.map{ |event| Moneybird::Resource::Generic::Event.build(event) }
    end

    def payments=(payments)
      @payments ||= payments.map{ |payment| Moneybird::Resource::Invoice::Payment.build(payment) }
    end
  end
end
