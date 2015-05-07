require "spec_helper"

describe Avalara::API do
  maintain_contactology_configuration

  let(:configuration) { described_class.configuration }

  describe ".configuration" do
    it "yields a Avalara::Configuration instance" do
      described_class.configuration do |yielded|
        expect(yielded).to be_kind_of Avalara::Configuration
      end
    end

    it "yields the same configuration instance across multiple calls" do
      described_class.configuration do |config|
        described_class.configuration do |config2|
          expect(config.object_id).to eq config2.object_id
        end
      end
    end

    it "returns the configuration when queried" do
      described_class.configuration do |config|
        expect(described_class.configuration.object_id).to eq config.object_id
      end
    end

    it "may be explicitly overridden" do
      configuration = Avalara::Configuration.new
      expect {
        described_class.configuration = configuration
      }.to change { described_class.configuration }.to(configuration)
    end

    it "raises an ArgumentError when set to a non-Configuration object" do
      expect {
        described_class.configuration = "bad"
      }.to raise_error(ArgumentError)
    end
  end

  describe ".endpoint" do
    it "returns the configuration endpoint" do
      expect(described_class.endpoint).to eq configuration.endpoint
    end

    it "overrides the configuration endpoint" do
      expect {
        described_class.endpoint = "https://example.local/"
      }.to change { configuration.endpoint }.to("https://example.local/")
    end
  end

  describe ".username" do
    it "returns the configuration username" do
      configuration.username = "username"
      expect(described_class.username).to eq configuration.username
    end

    it "overrides the configuration username" do
      expect {
        described_class.username = "username"
      }.to change { configuration.username }.to("username")
    end
  end

  describe ".password" do
    it "returns the configuration password" do
      configuration.password = "password"
      expect(described_class.password).to eq configuration.password
    end

    it "overrides the configuration password" do
      expect {
        described_class.password = "password"
      }.to change { configuration.password }.to("password")
    end
  end

  describe ".version" do
    it "returns the configuration version" do
      configuration.version = "version"
      expect(described_class.version).to eq configuration.version
    end

    it "overrides the configuration version" do
      expect {
        described_class.version = "version"
      }.to change { configuration.version }.to("version")
    end
  end
end