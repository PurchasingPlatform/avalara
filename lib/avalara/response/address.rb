module Avalara
  module Response
    class AddressPayload < Avalara::Types::Stash
      property :line_1,        from: :Line1
      property :line_2,        from: :Line2
      property :line_3,        from: :Line3
      property :city,          from: :City
      property :region,        from: :Region
      property :county,        from: :County
      property :country,       from: :Country
      property :postal_code,   from: :PostalCode
      property :fips_code,     from: :FipsCode
      property :carrier_route, from: :CarrierRoute
      property :post_net,      from: :PostNet
      property :address_type,  from: :AddressType
    end
  end
end
