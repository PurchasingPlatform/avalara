require "spec_helper"

describe Avalara do
  maintain_contactology_configuration

  let(:configuration) { Avalara::API.configuration }

  describe ".validate_address", vcr: true do
    let(:address) { FactoryGirl.build_via_new(:valid_address) }
    let(:request) { Avalara.validate_address(address) }
    subject { request }

    context "failure", vcr: { cassette_name: "validate_address/failure" } do
      let(:address) { FactoryGirl.build_via_new(:invalid_address) }

      it "raises an error" do
        expect { subject }.to raise_error(Avalara::ApiError)
      end

      context "the returned error" do
        subject do
          begin
            request
          rescue Avalara::ApiError => e
            e.object.messages.first
          end
        end

        it { expect(subject.details).to eq "An exact street name match could not be found and phonetically matching the street name resulted in either no matches or matches to more than one street name." }
        it { expect(subject.refers_to).to eq "Address.Line1" }
        it { expect(subject.severity).to eq "Error" }
        it { expect(subject.source).to eq "Avalara.AvaTax.Services.Address" }
        it { expect(subject.summary).to eq "An exact street name match could not be found" }
      end
    end

    context "on timeout" do
      it "raises an avalara timeout error" do
        expect(Avalara::API).to receive(:get).and_raise(Timeout::Error)
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context "success with exact match", vcr: { :cassette_name => "validate_address/success" } do
      it { is_expected.to be_kind_of Avalara::Response::AddressPayload }

      it { expect(subject.result_code).to eq "Success" }

      it "returns one address" do
        expect(subject.address).to be_a Hash
      end

      context "the returned address" do
        let(:instance) { subject.address }

        it { expect(instance.line_1).to eq "office" }
        it { expect(instance.line_2).to eq "549 W Randolph St Ste 605" }
        it { expect(instance.line_3).to be_nil }
        it { expect(instance.city).to eq "Chicago" }
        it { expect(instance.region).to eq "IL" }
        it { expect(instance.country).to eq "US" }
        it { expect(instance.county).to eq "Cook" }
        it { expect(instance.postal_code).to eq "60661-2316" }
        it { expect(instance.fips_code).to eq "1703100000" }
        it { expect(instance.carrier_route).to eq "C047" }
        it { expect(instance.post_net).to eq "606612316559" }
        it { expect(instance.address_type).to eq "H" }
      end
    end

    context "success with corrected match", vcr: { :cassette_name => "validate_address/corrected_success" } do
      let(:address) { FactoryGirl.build_via_new(:wrong_zip_address) }

      it { is_expected.to be_kind_of Avalara::Response::AddressPayload }

      it { expect(subject.result_code).to eq "Success" }

      it "returns one address" do
        expect(subject.address).to be_a Hash
      end

      context "the returned address" do
        let(:instance) { subject.address }

        it { expect(instance.line_1).to eq "office" }
        it { expect(instance.line_2).to eq "549 W Randolph St Ste 605" }
        it { expect(instance.line_3).to be_nil }
        it { expect(instance.city).to eq "Chicago" }
        it { expect(instance.region).to eq "IL" }
        it { expect(instance.country).to eq "US" }
        it { expect(instance.county).to eq "Cook" }
        it { expect(instance.postal_code).to eq "60661-2316" }
        it { expect(instance.postal_code).to_not eq "93286" }
        it { expect(instance.fips_code).to eq "1703100000" }
        it { expect(instance.carrier_route).to eq "C047" }
        it { expect(instance.post_net).to eq "606612316559" }
        it { expect(instance.address_type).to eq "H" }
      end
    end
  end
end
