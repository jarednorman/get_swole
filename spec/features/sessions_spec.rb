require 'feature_helper'

RSpec.describe "sessions", type: :feature do
  let!(:user) do
    create(:user, email: "admin@example.com", password: "password")
  end

  scenario "logging in and then out" do
    visit "/"

    within('form') do
      fill_in "email", with: "admin@example.com"
      fill_in "password", with: "password"
      click_on "Login"
    end

    click_on "Log out (admin@example.com)"

    expect(page).to have_content "Login"
  end
end
