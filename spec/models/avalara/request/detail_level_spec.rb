require "spec_helper"

describe Avalara::Request::DetailLevel do
  let(:params) { attributes_for(:detail_level) }
  let(:detail_level) { FactoryGirl.build_via_new(:detail_level) }

  context "sets all attributes" do
    subject { detail_level }

    it { expect(subject.Line).to eq params[:line] }
    it { expect(subject.Summary).to eq params[:summary] }
    it { expect(subject.Document).to eq params[:document] }
    it { expect(subject.Tax).to eq params[:tax] }
    it { expect(subject.Diagnostic).to eq params[:diagnostic] }
  end
end
