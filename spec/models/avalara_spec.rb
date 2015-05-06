# encoding: UTF-8

require "spec_helper"

describe Avalara do
  maintain_contactology_configuration

  let(:configuration) { Avalara.configuration }

  describe ".configuration" do
    it "yields a Avalara::Configuration instance" do
      Avalara.configuration do |yielded|
        expect(yielded).to be_kind_of Avalara::Configuration
      end
    end

    it "yields the same configuration instance across multiple calls" do
      Avalara.configuration do |config|
        Avalara.configuration do |config2|
          expect(config.object_id).to eq config2.object_id
        end
      end
    end

    it "returns the configuration when queried" do
      Avalara.configuration do |config|
        expect(Avalara.configuration.object_id).to eq config.object_id
      end
    end

    it "may be explicitly overridden" do
      configuration = Avalara::Configuration.new
      expect {
        Avalara.configuration = configuration
      }.to change { Avalara.configuration }.to(configuration)
    end

    it "raises an ArgumentError when set to a non-Configuration object" do
      expect {
        Avalara.configuration = "bad"
      }.to raise_error(ArgumentError)
    end
  end

  describe ".endpoint" do
    it "returns the configuration endpoint" do
      expect(Avalara.endpoint).to eq configuration.endpoint
    end

    it "overrides the configuration endpoint" do
      expect {
        Avalara.endpoint = "https://example.local/"
      }.to change { configuration.endpoint }.to("https://example.local/")
    end
  end

  describe ".username" do
    it "returns the configuration username" do
      configuration.username = "username"
      expect(Avalara.username).to eq configuration.username
    end

    it "overrides the configuration username" do
      expect {
        Avalara.username = "username"
      }.to change { configuration.username }.to("username")
    end
  end

  describe ".password" do
    it "returns the configuration password" do
      configuration.password = "password"
      expect(Avalara.password).to eq configuration.password
    end

    it "overrides the configuration password" do
      expect {
        Avalara.password = "password"
      }.to change { configuration.password }.to("password")
    end
  end

  describe ".version" do
    it "returns the configuration version" do
      configuration.version = "version"
      expect(Avalara.version).to eq configuration.version
    end

    it "overrides the configuration version" do
      expect {
        Avalara.version = "version"
      }.to change { configuration.version }.to("version")
    end
  end

  describe ".get_tax" do
    let(:doc_date) { Date.parse("January 1, 2012") }
    let(:invoice) { FactoryGirl.build_via_new(:invoice, doc_date: doc_date) }
    let(:request) { Avalara.get_tax(invoice) }
    subject { request }

    context "failure" do
      let(:invoice) { FactoryGirl.build_via_new(:invoice, customer_code: nil) }
      use_vcr_cassette "get_tax/failure"

      it "rasises an error" do
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

        it { expect(subject.details).to eq "This value must be specified." }
        it { expect(subject.refers_to).to eq "CustomerCode" }
        it { expect(subject.severity).to eq "Error" }
        it { expect(subject.source).to eq "Avalara.AvaTax.Services" }
        it { expect(subject.summary).to eq "CustomerCode is required." }
      end
    end

    context "on timeout" do
      it "raises an avalara timeout error" do
        expect(Avalara::API).to receive(:post).and_raise(Timeout::Error)
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context "success" do
      use_vcr_cassette "get_tax/success"

      it { is_expected.to be_kind_of Avalara::Response::Invoice }

      it { expect(subject.doc_code).to_not be_nil }
      it { expect(subject.doc_date).to eq "2012-01-01" }
      it { expect(subject.result_code).to eq "Success" }
      it { expect(subject.tax_date).to_not be_nil }
      it { expect(subject.timestamp).to_not be_nil }
      it { expect(subject.total_amount).to eq "10" }
      it { expect(subject.total_discount).to eq "0" }
      it { expect(subject.total_exemption).to eq "10" }
      it { expect(subject.total_tax).to eq "0" }
      it { expect(subject.total_tax_calculated).to eq "0" }

      it "returns 1 tax line" do
        expect(subject.tax_lines.length).to eq 1
      end

      it "returns 1 tax address" do
        expect(subject.tax_addresses.length).to eq 1
      end

      context "the returned tax line" do
        let(:tax_line) { request.tax_lines.first }
        subject { tax_line }

        it { expect(subject.line_no).to eq "1" }
        it { expect(subject.tax_code).to eq "P0000000" }
        it { expect(subject.taxability).to eq "true" }
        it { expect(subject.taxable).to eq "0" }
        it { expect(subject.rate).to eq "0" }
        it { expect(subject.tax).to eq "0" }
        it { expect(subject.discount).to eq "0" }
        it { expect(subject.tax_calculated).to eq "0" }
        it { expect(subject.exemption).to eq "10" }

        it "returns 1 tax detail" do
          expect(subject.tax_details.length).to eq 1
        end

        context "the returned tax detail" do
          subject { tax_line.tax_details.first }

          it { expect(subject.taxable).to eq "0" }
          it { expect(subject.rate).to eq "0" }
          it { expect(subject.tax).to eq "0" }
          it { expect(subject.region).to eq "WA" }
          it { expect(subject.country).to eq "US" }
          it { expect(subject.juris_type).to eq "State" }
          it { expect(subject.juris_name).to eq "WASHINGTON" }
          it { expect(subject.tax_name).to eq "WA STATE TAX" }
        end
      end
    end
  end
end
