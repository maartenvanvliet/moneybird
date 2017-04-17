module Moneybird
  module Traits
    module Save
      CREATE_SUCCESS_CODE = 201
      UPDATE_SUCCESS_CODE = 200

      def resource_path(resource)
        [path, resource.path].join('')
      end

      def save(resource)
        if resource.persisted?
          client.patch(resource_path(resource), resource.to_json)
          if client._last_response.status.to_i == UPDATE_SUCCESS_CODE
            resource.attributes = JSON.parse(client._last_response.body)
          else
            resource.errors = client._last_response.body
            return false
          end
        else
          client.post(resource_path(resource), resource.to_json)
          if client._last_response.status.to_i == CREATE_SUCCESS_CODE
            resource.attributes = JSON.parse(client._last_response.body)
          else
            resource.errors = client._last_response.body
            return false
          end
        end
        true
      end

      def create(attributes)
        resource = build(attributes)
        save(resource)
        resource
      end

      def update(attributes)
        resource = build(attributes)
        save(resource)
        resource
      end
    end
  end
end
