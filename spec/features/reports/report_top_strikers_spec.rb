require "rails_helper"

RSpec.feature "Listing Top Strikers" do

  before do
    @player_a = { "id" => 1, "name" => "Test 1", "avatar" => nil, "goals" => 1, "assist" => 2 }
    @player_b = { "id" => 2, "name" => "Test 2", "avatar" => nil, "goals" => 2, "assist" => 3 }
    @top_strikers = { "2018"  =>  [ @player_a, @player_b] }
  end

  scenario "User view 'Top Strikers' as initial page" do
    visit("/")
    expect(page).to have_content(I18n.t('content.reports.titles.strikers'))
  end

  scenario "A user lists all players that have goals or assists" do
    Season.stubs(:update_top_strikers).returns(@top_strikers)
    visit "/"
    expect(page).to have_content(@player_a["name"])
    expect(page).to have_content(@player_b["name"])
    expect(page).to have_content("2")
    expect(page).to have_content("3")
  end
end
