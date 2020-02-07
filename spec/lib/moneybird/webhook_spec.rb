require "spec_helper"

describe Moneybird::Webhook do
  let(:webhook) { Moneybird::Webhook.from_json(fixture_response(:sales_invoice, :webhooks)) }

  it "builds an entity" do
    webhook.build_entity.must_be_instance_of Moneybird::Resource::SalesInvoice
  end

  it "has an entity" do
    webhook.build_entity.id.must_equal 116015245643744263
  end

  it "knows the api entity" do
    webhook.entity_resource_class.must_equal Moneybird::Resource::SalesInvoice
  end

  describe "without entity data" do
    let(:webhook) { Moneybird::Webhook.from_json(fixture_response(:delete_sales_invoice, :webhooks)) }

    it "returns nil" do
      webhook.build_entity.must_be_nil
    end
  end
end
