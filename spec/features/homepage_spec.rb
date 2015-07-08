require 'feature_helper'

RSpec.describe "the homepage", type: :feature do
  scenario "visiting the homepage" do
    visit "/"
    expect(page).to have_content "Get Swole"
    expect(page).to have_content "TODO"
  end
end
