require "rails_helper"

RSpec.feature "Player detail" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryBot.build(:season)
    @season.matches << FactoryBot.build_list(:match, 4)
    @players = FactoryBot.build_list(:player, 3)
    @season.matches.each do |match|
      @players.each do |player|
        match.presences << FactoryBot.build(:presence, player: player, goals: 1, assist: 3)
        match.save
      end
    end
    @season.save
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

    @new_season = FactoryBot.build(:season)
    @new_season.matches << FactoryBot.build_list(:match, 4)
    @new_season.matches.each do |match|
      match.presences << FactoryBot.build(:presence, player: player, goals: 2)
    end
    @new_season.save

    visit reports_player_path(id: player.id, season: @season.id)
    expect(page).to have_content(player.name)
    expect(page).to have_content(4)
  end


end
