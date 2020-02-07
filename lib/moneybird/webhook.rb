module Moneybird
  class Webhook
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      administration_id
      webhook_id
      entity_type
      entity_id
      state
      action
      entity
    )

    def build_entity
      entity_resource_class.new(entity) if entity
    end

    def entity_resource_class
      Object.const_get "Moneybird::Resource::#{entity_type}"
    end

    def self.from_json(payload)
      build(JSON.parse(payload))
    end
  end
end