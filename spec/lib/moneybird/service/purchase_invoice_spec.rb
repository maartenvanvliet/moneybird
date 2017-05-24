require "spec_helper"

describe Moneybird::Service::PurchaseInvoice do
  let(:client) { faked_client }

  let(:service) { Moneybird::Service::PurchaseInvoice.new(client, '123') }

  describe "#all" do
    before do
      client.http.register_request(:GET, '/api/v2/123/documents/purchase_invoices',
        FakeResponse.new(200, json_response(:purchase_invoices)))
    end

    it "returns list of purchase_invoices" do
      purchase_invoices = service.all

      purchase_invoices.length.must_equal 1
      purchase_invoices.first.id.must_equal "151541225475802119"
    end
  end
end
