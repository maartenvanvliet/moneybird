module Moneybird
  module Traits
    module FindAll
      GET_SUCCESS_CODE = 200

      def all
        result = client.get(path)

        if result.status.to_i == GET_SUCCESS_CODE
          JSON.parse(result.body).map do |resource|
            build(resource)
          end
        end
      end
    end
  end
end