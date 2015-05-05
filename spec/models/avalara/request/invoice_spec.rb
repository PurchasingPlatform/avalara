# encoding: UTF-8

require "spec_helper"

describe Avalara::Request::Invoice do
  let(:params) { attributes_for(:invoice) }
  let(:invoice) { FactoryGirl.build_via_new(:invoice) }

  context "sets all attributes" do
    subject { invoice }

    it { expect(subject.CustomerCode).to eq params[:customer_code] }
    it { expect(subject.DocDate).to eq Avalara::Types::Date.coerce(params[:doc_date]) }
    it { expect(subject.CompanyCode).to eq params[:company_code] }
    it { expect(subject.Commit).to eq params[:commit] }
    it { expect(subject.CustomerUsageType).to eq params[:customer_usage_type] }
    it { expect(subject.Discount).to eq params[:discount] }
    it { expect(subject.DocCode).to eq params[:doc_code] }
    it { expect(subject.PurchaseOrderNo).to eq params[:purchase_order_no] }
    it { expect(subject.ExemptionNo).to eq params[:exemption_no] }
    it { expect(subject.DetailLevel).to eq params[:detail_level] }
    it { expect(subject.DocType).to eq params[:doc_type] }
    it { expect(subject.PaymentDate).to eq params[:payment_date] }
    it { expect(subject.Lines).to eq params[:lines] }
    it { expect(subject.Addresses).to eq params[:addresses] }
    it { expect(subject.ReferenceCode).to eq params[:reference_code] }
  end

  context "converts nested objects to json" do
    subject { invoice.to_json }
    it { is_expected.to_not be_nil }
  end
end
