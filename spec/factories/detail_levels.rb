FactoryGirl.define do
  factory :detail_level, class: Avalara::Request::DetailLevel do
    line "line"
    summary "summary"
    document "document"
    tax "tax"
    diagnostic "diagnostic"
  end
end
