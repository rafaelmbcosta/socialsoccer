require "rails_helper"

RSpec.feature "Listing Players" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryBot.build(:season)
    @season.matches << FactoryBot.build_list(:match, 4)
    @players = FactoryBot.build_list(:player, 3)
    @season.matches.each do |match|
      @players.each do |player|
        match.presences << FactoryBot.build(:presence, player: player)
      end
    end
    @season.save
  end

  scenario "User select 'Players' from the main menu" do
    visit("/")
    click_link I18n.t('content.menu.players')
    expect(page.current_path).to eq(reports_players_path)
    expect(page).to have_content(I18n.t('content.reports.players'))
  end

  scenario "A user lists all players" do
    visit reports_players_url

    expect(page).to have_content(@players[0].name)
    expect(page).to have_content(@players[1].name)
    expect(page).to have_content(@players[2].name)
    expect(page).to have_content(@season.matches.size)
  end

  scenario "A user lists players from previous seasons" do
    @new_season = FactoryBot.create(:season)
    @new_match = FactoryBot.create(:match, season: @new_season)
    @new_player = FactoryBot.create(:player)
    presence = FactoryBot.create(:presence, player: @new_player, match: @new_match)
    @new_match.presences << presence

    visit reports_players_url
    expect(page).not_to have_content(@players[0].name)
    expect(page).to have_content(@new_player.name)
    expect(page).to have_content(1)

    visit reports_players_url(id: @season.id)
    expect(page).to have_content(@players[0].name)
    expect(page).to have_content(4)
    expect(page).to have_content(@players[1].name)
    expect(page).not_to have_content(@new_player.name)
  end

end
