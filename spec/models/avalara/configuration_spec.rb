# encoding: UTF-8

require "spec_helper"

describe Avalara::Configuration do
  let(:configuration) { Avalara::Configuration.new }

  context "#endpoint" do
    it "defaults to https://rest.avalara.net" do
      expect(configuration.endpoint).to eq "https://rest.avalara.net"
    end

    it "may be overridden" do
      expect {
        configuration.endpoint = "https://example.local/"
      }.to change{ configuration.endpoint }.to("https://example.local/")
    end
  end

  context "#version" do
    it "defaults to 1.0" do
      expect(configuration.version).to eq "1.0"
    end

    it "may be overridden" do
      expect {
        configuration.version = "2.0"
      }.to change{ configuration.version }.to("2.0")
    end
  end

  context "#username" do
    it "is unset by default" do
      expect(configuration.username).to be_nil
    end

    it "may be set" do
      expect {
        configuration.username = "abcdefg"
      }.to change{ configuration.username }.to("abcdefg")
    end
  end

  context "#password" do
    it "is unset by default" do
      expect(configuration.password).to be_nil
    end

    it "may be set" do
      expect {
        configuration.password = "abcdefg"
      }.to change{ configuration.password }.to("abcdefg")
    end
  end
end