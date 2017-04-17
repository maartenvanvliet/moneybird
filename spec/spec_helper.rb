if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/spec'
require 'minitest/autorun'

require 'moneybird'

FakeRequest = Struct.new(:method, :path, :body)
FakeResponse = Struct.new(:status, :body)

class FakeHttp
  attr_reader :requests, :registered_requests
  attr_accessor :_next_response

  def initialize
    @_next_response = nil
  end

  def request(http_request)
    @requests ||= []
    @requests << [http_request.method.to_s,  http_request.path, http_request.body]

    @_next_response || mapped_response(http_request.method, http_request.path) || raise("No reponse registered for #{net_http_request.method}: #{net_http_request.path}")
  end

  def register_request(method, path, response)
    @registered_requests ||= {}
    @registered_requests[method.to_sym] ||= {}
    @registered_requests[method.to_sym][path] = response
  end

  def mapped_response(method, path)
    @registered_requests ||= {}
    @registered_requests[method.to_sym] ||= {}
    @registered_requests[method.to_sym][path]
  end

  def reset!
    @requests = []
    @registered_requests = {}
    @_next_response = nil
  end

  def get(url, params, headers)
    request(FakeRequest.new(:GET, url, nil))
  end

  def delete(url, params, headers)
    request(FakeRequest.new(:DELETE, url, nil))
  end

  def post(url, body, headers)
    request(FakeRequest.new(:POST, url, body))
  end

  def patch(url, body, headers)
    request(FakeRequest.new(:PATCH, url, body))
  end
end



def json_response(file)
  File.read("spec/fixtures/responses/#{file}.json")
end

def json_webhook(file)
  File.read("spec/fixtures/webhooks/#{file}.json")
end

def hash_response(file)
  JSON.parse(File.read("spec/fixtures/responses/#{file}.json"))
end


def faked_client
  faked_client = Moneybird::Client.new("bearer token")
  faked_client.http = FakeHttp.new
  faked_client
end