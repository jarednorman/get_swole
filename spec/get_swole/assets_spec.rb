require 'spec_helper'

RSpec.describe GetSwole::Assets do
  describe ".call" do
    subject { described_class.new.call(rack_env) }

    let(:rack_env) { double "env" }

    it "delegates to Sprockets::Environment" do
      expect_any_instance_of(Sprockets::Environment).
        to receive(:call).
        with(rack_env)

      subject
    end
  end

  describe ".url_for" do
    subject { described_class.new.url_for(asset) }

    context "when an asset host is set" do
      before { ENV["ASSET_HOST"] = 'http://example.com' }
      after { ENV["ASSET_HOST"] = nil }

      context "when the asset exists" do
        let(:asset) { "swole.css" }

        it { is_expected.to eq "http://example.com/get/swole.css" }
      end

      context "when the asset exists in production" do
        let(:asset) { "swole.css" }
        before do
          allow(GetSwole).
            to receive(:production?).
            and_return(true)
        end

        it "returns a fingerprinted asset url" do
          expect(subject).
            to match %r(http://example\.com/get/swole-[a-z0-9]{64}\.css)
        end
      end

      context "when the asset doesn't exist" do
        let(:asset) { "wizard.css" }

        it "raises an error" do
          expect { subject }.to raise_error 'No such asset: "wizard.css"'
        end
      end
    end

    context "when no asset host is set" do
      context "when the asset exists" do
        let(:asset) { "swole.css" }

        it { is_expected.to eq "/get/swole.css" }
      end

      context "when the asset doesn't exist" do
        let(:asset) { "wizard.css" }

        it "raises an error" do
          expect { subject }.to raise_error 'No such asset: "wizard.css"'
        end
      end
    end
  end

  describe ".prefix" do
    subject { described_class.new.prefix }
    it { is_expected.to eq "get" }
  end
end
