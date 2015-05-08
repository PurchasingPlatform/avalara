# require "spec_helper"
#
# describe Avalara do
#   maintain_contactology_configuration
#
#   let(:configuration) { Avalara::API.configuration }
#
#   describe ".validate_address", vcr: true do
#     let(:doc_date) { Date.parse("January 1, 2012") }
#     let(:address) { FactoryGirl.build_via_new(:address) }
#     let(:request) { Avalara.validate_address(address) }
#     subject { request }
#
#     VCR.use_cassette("validate_address/good") do
#       address = FactoryGirl.build_via_new(:valid_address)
#       Avalara.validate_address(address)
#     end
#
#     context "failure", vcr: { :cassette_name => "get_tax/failure" } do
#       let(:address) { FactoryGirl.build_via_new(:address) }
#
#       it "raises an error" do
#         expect { subject }.to raise_error(Avalara::ApiError)
#       end
#
#       context "the returned error" do
#         subject do
#           begin
#             request
#           rescue Avalara::ApiError => e
#             e.object.messages.first
#           end
#         end
#
#         it { expect(subject.details).to eq "This value must be specified." }
#         it { expect(subject.refers_to).to eq "CustomerCode" }
#         it { expect(subject.severity).to eq "Error" }
#         it { expect(subject.source).to eq "Avalara.AvaTax.Services" }
#         it { expect(subject.summary).to eq "CustomerCode is required." }
#       end
#     end
#
#     context "on timeout" do
#       it "raises an avalara timeout error" do
#         expect(Avalara::API).to receive(:post).and_raise(Timeout::Error)
#         expect { subject }.to raise_error(Avalara::TimeoutError)
#       end
#     end
#
#   context "success", vcr: { :cassette_name => "get_tax/success" } do
#       it { is_expected.to be_kind_of Avalara::Response::Invoice }
#
#       it { expect(subject.doc_code).to_not be_nil }
#       it { expect(subject.doc_date).to eq "2012-01-01" }
#       it { expect(subject.result_code).to eq "Success" }
#       it { expect(subject.tax_date).to_not be_nil }
#       it { expect(subject.timestamp).to_not be_nil }
#       it { expect(subject.total_amount).to eq "10" }
#       it { expect(subject.total_discount).to eq "0" }
#       it { expect(subject.total_exemption).to eq "10" }
#       it { expect(subject.total_tax).to eq "0" }
#       it { expect(subject.total_tax_calculated).to eq "0" }
#
#       it "returns 1 tax line" do
#         expect(subject.tax_lines.length).to eq 1
#       end
#
#       it "returns 1 tax address" do
#         expect(subject.tax_addresses.length).to eq 1
#       end
#
#       context "the returned tax line" do
#         let(:tax_line) { request.tax_lines.first }
#         subject { tax_line }
#
#         it { expect(subject.line_no).to eq "1" }
#         it { expect(subject.tax_code).to eq "P0000000" }
#         it { expect(subject.taxability).to eq "true" }
#         it { expect(subject.taxable).to eq "0" }
#         it { expect(subject.rate).to eq "0" }
#         it { expect(subject.tax).to eq "0" }
#         it { expect(subject.discount).to eq "0" }
#         it { expect(subject.tax_calculated).to eq "0" }
#         it { expect(subject.exemption).to eq "10" }
#
#         it "returns 1 tax detail" do
#           expect(subject.tax_details.length).to eq 1
#         end
#
#         context "the returned tax detail" do
#           subject { tax_line.tax_details.first }
#
#           it { expect(subject.taxable).to eq "0" }
#           it { expect(subject.rate).to eq "0" }
#           it { expect(subject.tax).to eq "0" }
#           it { expect(subject.region).to eq "WA" }
#           it { expect(subject.country).to eq "US" }
#           it { expect(subject.juris_type).to eq "State" }
#           it { expect(subject.juris_name).to eq "WASHINGTON" }
#           it { expect(subject.tax_name).to eq "WA STATE TAX" }
#         end
#       end
#     end
#   end
# end
