require "spec_helper"

describe Moneybird::Resource::Webhook do
  let(:client) { Moneybird::Client.new('bearer token') }
  let(:webhook) { Moneybird::Resource::Webhook.build(hash_response(:webhook)) }

  it "has no nested json representation" do
    _(JSON.parse(webhook.to_json)).must_equal(
      {
        "id" => "194733605680842680",
        "administration_id" => 123,
        "url" => "http://example.com/webhook",
        "enabled_events" => []
      }
    )
  end
end
