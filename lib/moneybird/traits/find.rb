module Moneybird
  module Traits
    module Find
      GET_SUCCESS_CODE = 200

      def find(id)
        result = client.get("#{path}/#{id}")

        if result.status.to_i == GET_SUCCESS_CODE
          build(JSON.parse(result.body))
        end
      end
    end
  end
end