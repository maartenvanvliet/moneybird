require 'faraday_middleware'

module Moneybird
  class Client
    attr_reader :bearer_token
    attr_accessor :errors
    attr_writer :http, :faraday_adapter

    def initialize(bearer_token)
      @bearer_token = bearer_token
    end

    def base_url
      "https://moneybird.com/"
    end

    def version
      @version ||= 'v2'
    end

    def faraday_adapter
      @faraday_adapter ||= Faraday.default_adapter
    end

    def http
      @http ||= Faraday.new(url: base_url) do |faraday|
        faraday.headers = faraday_headers
        faraday.request :url_encoded
        faraday.response :json, content_type: /\bjson$/
        faraday.use Moneybird::Middleware::ErrorHandling
        faraday.use Moneybird::Middleware::Pagination

        faraday.adapter faraday_adapter
      end
    end

    %i[get patch post delete].each do |call|
      define_method call do |path, options = {}|
        response = http.public_send(call, "/api/#{version}/#{path}", options)
        if response.status == 302
          response['Location']
        else
          response.body
        end
      end
    end

    def get_all_pages(path, options = {})
      get_each_page(path, options).inject([]) do |array, objects|
        array += objects
      end
    end

    def get_each_page(path, options = {})
      return enum_for(:get_each_page, path, options) unless block_given?
      path = "/api/#{version}/#{path}"
      while path
        response = http.get(path, options)
        yield response.body
        path = (response[:pagination_links].next if response[:pagination_links])
      end
    end

    def administrations
      Moneybird::Service::Administration.new(self).all
    end

    private

    def faraday_headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{bearer_token}"
      }
    end
  end
end
