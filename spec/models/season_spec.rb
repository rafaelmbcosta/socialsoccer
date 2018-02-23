require 'rails_helper'

RSpec.describe Season, type: :model do

  before do
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end

  describe "Associations" do
    it { should have_many :matches }
    it { should have_many :presences }
  end

  describe "Scope 'update_top_strikers'" do
    before do
      @season = FactoryBot.build(:season)
      @season.matches << FactoryBot.build_list(:match, 3)
      @first_player = FactoryBot.build(:player)
      @second_player = FactoryBot.build(:player)
      @bad_player = FactoryBot.build(:player)
      @not_so_bad_player = FactoryBot.build(:player)
      @season.matches.each do |match|
        match.presences << FactoryBot.build(:presence, player: @first_player, goals: 2, assist: 1)
        match.presences << FactoryBot.build(:presence, player: @second_player, goals: 3, assist: 0)
        match.presences << FactoryBot.build(:presence, player: @bad_player, goals: 0, assist: 0)
        match.presences << FactoryBot.build(:presence, player: @not_so_bad_player, goals: 0, assist: 1)
      end
      @season.save
    end

    it "should return a hash" do
      expect(Season.update_top_strikers).to be_instance_of(Hash)
    end

    it "should not return player without goals or assists" do
      expect(Season.update_top_strikers[@season.number.to_s]).not_to include(
        {
          "id" => @bad_player.id,
          "name"=> "#{@bad_player.name} (#{@bad_player.nickname})",
          "avatar" => nil, "goals" => 0, "assist" => 0
        }
      )
    end

    it "should return the strikers" do
      expect(Season.update_top_strikers[@season.number.to_s]).to include(
        {
          "id" => @first_player.id,
          "name"=> "#{@first_player.name} (#{@first_player.nickname})",
          "avatar" => nil, "goals" => 6, "assist" => 3
        }
      )
    end
  end

  describe "Scope 'financial_report'" do
    let(:past_season) { FactoryBot.create(:season, number: 2017) }
    let(:player) { FactoryBot.create(:player) }
    let(:past_match) { FactoryBot.create(:match, season: past_season) }
    let(:presence ) { FactoryBot.create(:presence, match: match, player: player) }

    it "empty for < 2018" do
      expect(Season.financial_report).to eq([])
    end

    let(:season) { FactoryBot.create(:season, number: 2018) }

    it "should bring season results" do
      past_match.update(season: season)
      past_match.season = season
      past_match.save
      expect(Season.financial_report).to eq([{
        "season" =>  season,
        "matches"=> 1,
        "to_pay" => past_match.field_value,
        "received" => 0,
        "balance" => - past_match.field_value
      }])
    end
  end
end
