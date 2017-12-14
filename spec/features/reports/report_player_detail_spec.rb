require "rails_helper"

RSpec.feature "Player detail" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryGirl.build(:season)
    @season.matches << FactoryGirl.build_list(:match, 4)
    @players = FactoryGirl.build_list(:player, 3)
    @season.matches.each do |match|
      @players.each do |player|
        match.presences << FactoryGirl.build(:presence, player: player, goals: 1, assist: 3)
        match.save
      end
    end
    @season.save
  end

  scenario "User select player detail from the player list" do
    visit reports_players_url
    player = @players.first
    find(".player_#{player.id}").click
    expect(current_path).to eq(reports_player_path(player.id))
    expect(page).to have_content(player.name)
  end

  scenario "User see details of the player" do
    player = @players.first
    visit reports_player_path(player.id)
    expect(page).to have_content(player.name)
    expect(page).to have_content(4) # goals
    expect(page).to have_content(12) # assists
  end

  scenario "User see details of the player from past seasons" do
    player = @players.first
    visit reports_player_path(player.id)

    @new_season = FactoryGirl.build(:season)
    @new_season.matches << FactoryGirl.build_list(:match, 4)
    @new_season.matches.each do |match|
      match.presences << FactoryGirl.build(:presence, player: player, goals: 2)
    end
    @new_season.save

    visit reports_player_path(id: player.id, season: @season.id)
    expect(page).to have_content(player.name)
    expect(page).to have_content(4)
  end


end
