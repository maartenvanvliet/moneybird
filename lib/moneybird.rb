
require 'active_support'
require 'active_support/core_ext/object/json'
require 'active_support/core_ext/string/inflections'
require 'faraday'

require 'logger'
require 'uri'
require 'json'
require 'net/http'

module Moneybird
  module HttpError; end
  module Middleware; end
  module Service; end
  module Traits; end
end

require 'moneybird/resource'

##
# Middleware
require 'moneybird/middleware/pagination/links'
require 'moneybird/middleware/pagination' # Depends on links

##
# Resources (all depend on resource)
require 'moneybird/resource/documents/general_document'
require 'moneybird/resource/documents/general_journal_document'
require 'moneybird/resource/documents/purchase_invoice'
require 'moneybird/resource/documents/receipt'
require 'moneybird/resource/documents/typeless_document'
require 'moneybird/resource/generic/event'
require 'moneybird/resource/generic/note'
require 'moneybird/resource/invoice/details'
require 'moneybird/resource/invoice/payment'
require 'moneybird/resource/contact' # Depends on generic resources
require 'moneybird/resource/document_style'
require 'moneybird/resource/custom_field'
require 'moneybird/resource/estimate'
require 'moneybird/resource/financial_account'
require 'moneybird/resource/financial_mutation'
require 'moneybird/resource/identity'
require 'moneybird/resource/ledger_account'
require 'moneybird/resource/product'
require 'moneybird/resource/recurring_sales_invoice' # Depends on generic and invoice resources
require 'moneybird/resource/sales_invoice' # Depends on generic and invoice resources
require 'moneybird/resource/external_sales_invoice'
require 'moneybird/resource/synchronization'
require 'moneybird/resource/tax_rate'
require 'moneybird/resource/webhook'
require 'moneybird/resource/workflow'

##
# Traits
require 'moneybird/traits/administration_service'
require 'moneybird/traits/delete'
require 'moneybird/traits/download_pdf'
require 'moneybird/traits/find'
require 'moneybird/traits/find_all'
require 'moneybird/traits/mark_as_uncollectible'
require 'moneybird/traits/save'
require 'moneybird/traits/send_invoice'
require 'moneybird/traits/service'
require 'moneybird/traits/synchronization' # Depends on synchronization resource

##
# Services (all depend on traits and it's associated resource)
require 'moneybird/service/documents/general_document'
require 'moneybird/service/documents/general_journal_document'
require 'moneybird/service/documents/purchase_invoice'
require 'moneybird/service/documents/receipt'
require 'moneybird/service/documents/typeless_document'
require 'moneybird/service/contact'
require 'moneybird/service/document_style'
require 'moneybird/service/custom_field'
require 'moneybird/service/estimate'
require 'moneybird/service/financial_account'
require 'moneybird/service/financial_mutation'
require 'moneybird/service/identity'
require 'moneybird/service/ledger_account'
require 'moneybird/service/product'
require 'moneybird/service/recurring_sales_invoice'
require 'moneybird/service/sales_invoice'
require 'moneybird/service/external_sales_invoice'
require 'moneybird/service/tax_rate'
require 'moneybird/service/webhook'
require 'moneybird/service/workflow'
require 'moneybird/service/payment'

##
# Special cases
require 'moneybird/resource/administration' # Depends on services
require 'moneybird/service/administration' # Depends on administration resource
require 'moneybird/client'
require 'moneybird/version'
require 'moneybird/webhook'
