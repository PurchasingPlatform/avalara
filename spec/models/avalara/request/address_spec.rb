# encoding: UTF-8

require "spec_helper"

describe Avalara::Request::Address do
  let(:params) { attributes_for(:address) }
  let(:address) { FactoryGirl.build_via_new(:address, params) }

  context "sets all attributes" do
    subject { address }

    it { expect(subject.AddressCode).to eq params[:address_code] }
    it { expect(subject.Line1).to eq params[:line_1] }
    it { expect(subject.Line2).to eq params[:line_2] }
    it { expect(subject.Line3).to eq params[:line_3] }
    it { expect(subject.City).to eq params[:city] }
    it { expect(subject.Region).to eq params[:region] }
    it { expect(subject.Country).to eq params[:country] }
    it { expect(subject.PostalCode).to eq params[:postal_code] }
    it { expect(subject.Latitude).to eq params[:latitude] }
    it { expect(subject.Longitude).to eq params[:longitude] }
    it { expect(subject.TaxRegionId).to eq params[:tax_region_id] }
  end
end
