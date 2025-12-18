module Moneybird::Resource
  class Webhook
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      id
      administration_id
      url
      last_http_status
      last_http_body
      enabled_events
      token
    )

    def to_json
      JSON.generate(attributes.as_json)
    end
  end
end


