
require 'active_support'
require 'active_support/core_ext/object/json'
require 'active_support/core_ext/string/inflections'
require 'faraday'

require 'logger'
require 'uri'
require 'json'
require 'net/http'

module Moneybird
  module Service; end;
  module Traits; end;
end

require "moneybird/traits/administration_service"
require "moneybird/traits/find"
require "moneybird/traits/find_all"
require "moneybird/traits/service"
require "moneybird/traits/save"
require "moneybird/traits/delete"
require "moneybird/client"
require "moneybird/resource"
require "moneybird/webhook"

Dir[File.join(File.dirname(__FILE__), 'moneybird/service', '**/*.rb')].each  do |service|
  require service
end

Dir[File.join(File.dirname(__FILE__), 'moneybird/resource', '**/*.rb')].each  do |resource|
  require resource
end

require "moneybird/version"
