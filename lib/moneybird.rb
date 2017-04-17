
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
require "moneybird/resource/invoice/details"
require "moneybird/resource/generic/note"
require "moneybird/resource/generic/event"
require "moneybird/webhook"

resources = %w(
 administration
 contact
 document_style
 estimate
 financial_account
 financial_mutation
 identity
 ledger_account
 product
 recurring_sales_invoice
 sales_invoice
 tax_rate
 webhook
 workflow
)

resources.each do |resource|
  require "moneybird/service/#{resource}"
  require "moneybird/resource/#{resource}"
end



require "moneybird/version"
