require "spec_helper"

describe Moneybird::Service::SalesInvoice do
  let(:client) { Moneybird::Client.new('bearer token') }
  let(:service) { Moneybird::Service::SalesInvoice.new(client, '123') }

  describe "#all" do
    before do
      stub_request(:get, 'https://moneybird.com/api/v2/123/sales_invoices')
        .to_return(status: 200, body: fixture_response(:sales_invoices))
    end

    it "returns list of sales_invoices" do
      sales_invoices = service.all

      _(sales_invoices.length).must_equal 3
      _(sales_invoices.first.id).must_equal "194733567493801235"
    end
  end

  describe "#save" do
    let(:id) { '1' }
    let(:attributes) { { id: id, reference: 'FooBar' } }

    it "creates when not persisted" do
      stub_request(:post, "https://moneybird.com/api/v2/123/sales_invoices")
        .to_return(status: 201, body: fixture_response(:sales_invoice))
      attributes.delete(:id)

      resource = service.build(attributes)
      _(service.save(resource)).must_equal resource
    end

    it "updates when persisted" do
      stub_request(:patch, "https://moneybird.com/api/v2/123/sales_invoices/#{id}")
        .to_return(status: 200, body: fixture_response(:sales_invoice))

      resource = service.build(attributes)
      _(service.save(resource)).must_equal resource
    end
  end

  describe "#send_invoice" do
    before do
      stub_request(:patch, 'https://moneybird.com/api/v2/123/sales_invoices/456/send_invoice')
        .to_return(status: 200, headers: { content_type: "application/json" }, body: fixture_response(:sales_invoice))
    end
    let(:sales_invoice) { Moneybird::Resource::SalesInvoice.new(client: client, id: '456') }
    it "will send the invoice" do
      _(service.send_invoice(sales_invoice)).must_equal sales_invoice
    end
  end

  describe "#download_pdf" do
    before do
      stub_request(:get, 'https://moneybird.com/api/v2/123/sales_invoices/456/download_pdf')
        .to_return(
          status: 302,
          body: 'This resource has been moved temporarily.',
          headers: {
            'Location' => 'https://storage.moneybird.dev/036ce3bd95c725c04aa5b81ee9419f9b49246a4b91483c2ad913e31a99204fa6/36cabf4c517ca62001f1bd3c9e014b0cacb2f77e9c24ab432c72ca6dc1820b6e/download'
          })
    end
    it "will return download url" do
      _(service.download_pdf(456)).must_equal 'https://storage.moneybird.dev/036ce3bd95c725c04aa5b81ee9419f9b49246a4b91483c2ad913e31a99204fa6/36cabf4c517ca62001f1bd3c9e014b0cacb2f77e9c24ab432c72ca6dc1820b6e/download'
    end
  end

  describe "#mark_as_uncollectible" do
    before do
      stub_request(:patch, 'https://moneybird.com/api/v2/123/sales_invoices/456/mark_as_uncollectible')
        .to_return(status: 200, body: fixture_response(:sales_invoice))
    end
    let(:sales_invoice) { Moneybird::Resource::SalesInvoice.new(client: client, id: '456') }
    it "will mark the invoice as uncollectible" do
      _(service.mark_as_uncollectible(sales_invoice)).must_equal sales_invoice
    end
  end
end
