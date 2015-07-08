require 'spec_helper'

RSpec.describe GetSwole::User do
  describe "#valid?" do
    subject { user.valid? }

    let(:user) { build :user, user_attributes }

    context "without an email" do
      let(:user_attributes) do
        {
          email: nil,
          password: "12345"
        }
      end
      it { is_expected.to eq false }
    end

    context "without a password" do
      let(:user_attributes) do
        {
          email: "user@example.com",
          password: nil
        }
      end
      it { is_expected.to eq false }
    end

    context "with a username and password" do
      let(:user_attributes) do
        {
          email: "user@example.com",
          password: "12345"
        }
      end
      it { is_expected.to eq true }
    end
  end

  describe "#password=" do
    let(:user) { described_class.new }
    let(:password) { "childhood pet's name" }

    it "stores the hashed password" do
      user.password = password
      expect(user.hashed_password.to_s).not_to eq password
      expect(user.password).to eq password
    end
  end
end
