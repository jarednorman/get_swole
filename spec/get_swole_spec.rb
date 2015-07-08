require 'spec_helper'

RSpec.describe GetSwole do
  describe ".production?" do
    subject { described_class.production? }

    before { ENV['RACK_ENV'] = rack_env }
    after { ENV['RACK_ENV'] = 'test' }

    context 'when RACK_ENV is "production"' do
      let(:rack_env) { "production" }
      it { is_expected.to eq true }
    end

    context 'when RACK_ENV is "development"' do
      let(:rack_env) { "development" }
      it { is_expected.to eq false }
    end

    context 'when RACK_ENV is "test"' do
      let(:rack_env) { "test" }
      it { is_expected.to eq false }
    end
  end
end
