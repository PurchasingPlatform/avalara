FactoryGirl.define do
  factory :address, class: Avalara::Request::Address do
    address_code 1
    line_1 "549 W Randolph Street"
    line_2 "Suite 605"
    line_3 "office"
    city "Chicago"
    region "Illinois"
    country "USA"
    postal_code "60661"
    # c.latitude "latitude"
    # c.longitude "longitude"
    # c.tax_region_id "tax_region_id"
  end

  factory :valid_address, class: Avalara::Request::Address do
    line_1 "549 W Randolph St"
    line_2 "Suite 605"
    line_3 "office"
    city "Chicago"
    region "IL"
    country "USA"
    postal_code "60661"
  end

  factory :wrong_zip_address, class: Avalara::Request::Address do
    line_1 "549 W Randolph St"
    line_2 "Suite 605"
    line_3 "office"
    city "Chicago"
    region "IL"
    country "USA"
    postal_code "93286"
  end

  factory :invalid_address, class: Avalara::Request::Address do
    line_1 "123 Example St"
    city "Chicago"
    region "IL"
    country "USA"
    postal_code "60661"
  end
end
