require "rails_helper"

RSpec.feature "Listing Top Strikers" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryGirl.build(:season)
    @season.matches << FactoryGirl.build_list(:match, 3)
    @first_player = FactoryGirl.build(:player)
    @second_player = FactoryGirl.build(:player)
    @bad_player = FactoryGirl.build(:player)
    @not_so_bad_player = FactoryGirl.build(:player)
    @season.matches.each do |match|
      match.presences << FactoryGirl.build(:presence, player: @first_player, goals: 2, assist: 1)
      match.presences << FactoryGirl.build(:presence, player: @second_player, goals: 3, assist: 0)
      match.presences << FactoryGirl.build(:presence, player: @bad_player, goals: 0, assist: 0)
      match.presences << FactoryGirl.build(:presence, player: @not_so_bad_player, goals: 0, assist: 1)
    end
    @season.save
  end

  scenario "User view 'Top Strikers' as initial page" do
    visit("/")
    expect(page).to have_content(I18n.t('content.reports.titles.strikers'))
  end

  scenario "A user lists all players that have goals or assists" do
    visit "/"

    expect(page).to have_content(@first_player.name)
    expect(page).to have_content(@second_player.name)
    expect(page).to have_content(@not_so_bad_player.name)
    expect(page).not_to have_content(@bad_player.name)
  end
end
