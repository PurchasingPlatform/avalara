FactoryGirl.define do
  factory :address, :class => Avalara::Request::Address do
    address_code 1
    line_1 "435 Ericksen Avenue Northeast"
    line_2 "#250"
    # c.line_3 "line_3"
    # c.city "city"
    # c.region "region"
    # c.country "country"
    postal_code "98110"
    # c.latitude "latitude"
    # c.longitude "longitude"
    # c.tax_region_id "tax_region_id"
  end
end
