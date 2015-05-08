module Avalara
  module Response
    autoload :Invoice,    "avalara/response/invoice"
    autoload :Message,    "avalara/response/message"
    autoload :TaxLine,    "avalara/response/tax_line"
    autoload :TaxDetail,  "avalara/response/tax_detail"
    autoload :TaxAddress, "avalara/response/tax_address"
    autoload :Tax,        "avalara/response/tax"
    autoload :AddressPayload,        "avalara/response/address_payload"
    autoload :Address,        "avalara/response/address"
  end
end
