require "spec_helper"

describe Avalara::Request::Line do
  let(:params) { FactoryGirl.attributes_for(:line) }
  let(:line) { FactoryGirl.build_via_new(:line) }

  context "sets all attributes" do
    subject { line }

    it { expect(subject.LineNo).to eq params[:line_no] }
    it { expect(subject.DestinationCode).to eq params[:destination_code] }
    it { expect(subject.OriginCode).to eq params[:origin_code] }
    it { expect(subject.ItemCode).to eq params[:item_code] }
    it { expect(subject.TaxCode).to eq params[:tax_code] }
    it { expect(subject.CustomerUsageType).to eq params[:customer_usage_type] }
    it { expect(subject.Qty).to eq params[:qty] }
    it { expect(subject.Amount).to eq params[:amount] }
    it { expect(subject.Discounted).to eq params[:discounted] }
    it { expect(subject.TaxIncluded).to eq params[:tax_included] }
    it { expect(subject.Ref1).to eq params[:ref_1] }
    it { expect(subject.Ref2).to eq params[:ref_2] }
  end
end
