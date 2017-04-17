module Moneybird
  module Traits
    module Delete
      DELETE_SUCCESS_CODE = 204

      def delete(resource)
        client.delete(resource_path(resource))
        if client._last_response.status.to_i != DELETE_SUCCESS_CODE
          resource.errors = client._last_response.body
          return false
        end
        true
      end
    end
  end
end
