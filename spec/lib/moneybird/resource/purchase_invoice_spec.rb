require "spec_helper"

describe Moneybird::Resource::PurchaseInvoice do
  let(:client) { faked_client }

  let(:sales_invoice) do
    Moneybird::Resource::PurchaseInvoice.build(hash_response(:purchase_invoices).first
      .merge('notes' => [hash_response(:note)], 'payments' => [hash_response(:payment)]))
  end

  it "has a contact" do
    sales_invoice.contact.must_be_instance_of Moneybird::Resource::Contact
  end

  it "has details" do
    sales_invoice.details.first.must_be_instance_of Moneybird::Resource::Invoice::Details
  end

  it "has notes" do
    sales_invoice.notes.first.must_be_instance_of Moneybird::Resource::Generic::Note
  end

  it "has events" do
    sales_invoice.events.first.must_be_instance_of Moneybird::Resource::Generic::Event
  end

  it "has payments" do
    sales_invoice.payments.first.must_be_instance_of Moneybird::Resource::Invoice::Payment
  end
end
