module Moneybird
  class Client
    attr_reader :bearer_token, :_last_response
    attr_accessor :errors
    attr_writer :http, :faraday_adapter

    def initialize(bearer_token)
      @bearer_token = bearer_token
    end

    def base_url
      "https://moneybird.com/api/#{version}/"
    end

    def version
      @version ||= 'v2'
    end

    def faraday_adapter
      @faraday_adapter ||= Faraday.default_adapter
    end

    def http
      @http ||= begin
        uri = uri_for_path(base_url)
        http = Faraday.new(:url => uri) do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger
          faraday.adapter  faraday_adapter
        end
        http
      end
    end

    def headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{bearer_token}"
      }
    end

    def uri_for_path(path)
      URI.parse(File.join(base_url, path))
    end

    def get(path, headers={})
      uri = uri_for_path(path)
      @_last_response = http.get(uri.request_uri, nil, self.headers.merge(headers))
    end

    def patch(path, body=nil, headers={})
      uri = uri_for_path(path)
      @_last_response = http.patch(uri.request_uri, body, self.headers.merge(headers))
    end

    def post(path, body=nil, headers={})
      uri = uri_for_path(path)
      @_last_response = http.post(uri.request_uri, body, self.headers.merge(headers))
    end

    def delete(path, headers={})
      uri = uri_for_path(path)
      @_last_response = http.delete(uri.request_uri, nil, self.headers.merge(headers))
    end

    def administrations
      Moneybird::Service::Administration.new(self).all
    end
  end
end