module Moneybird::Service
  class Contact
    include Moneybird::Traits::AdministrationService
    include Moneybird::Traits::Service
    include Moneybird::Traits::Find
    include Moneybird::Traits::FindAll
    include Moneybird::Traits::Save
    include Moneybird::Traits::Delete

    def resource_class
      Moneybird::Resource::Contact
    end

    def path
      "#{administration_id}/contacts"
    end

    def find_by_customer_id(customer_id)
      result = client.get("#{path}/customer_id/#{customer_id}")

      if result.status.to_i == GET_SUCCESS_CODE
        build(JSON.parse(result.body))
      end
    end
  end
end