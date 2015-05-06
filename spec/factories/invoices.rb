FactoryGirl.define do
  factory :invoice, class: Avalara::Request::Invoice do
    customer_code 1
    doc_date Time.now
    company_code 83
    # c.commit "commit"
    # c.customer_usage_type "customer_usage_type"
    # c.discount "discount"
    # c.doc_code "doc_code"
    # c.purchase_order_no "purchase_order_no"
    # c.exemption_no "exemption_no"
    # c.detail_level
    # c.doc_type "doc_type"
    # c.payment_date "payment_date"
    lines { [FactoryGirl.build_via_new(:line)] }
    addresses { [FactoryGirl.build_via_new(:address)] }
    # c.reference_code "reference_code"
  end
end
