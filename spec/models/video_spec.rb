require "rails_helper"

RSpec.describe Match, :type => :model do

  describe "Associations" do
    it { should have_many :videos }
  end

  let!(:unfinished_match) { FactoryGirl.create(:match) }
  let!(:finished_match) { FactoryGirl.create(:match, date: Date.new, finished: true) }
  let!(:player) { FactoryGirl.create(:player) }

  #Service is stubbed (see rails helper)
  describe "Scope 'unfinished'" do
    it "must return only unfinished matches" do
      expect(Match.unfinished.size).to eq(1)
      expect(Match.unfinished.first.date).to be == unfinished_match.date
      expect(Match.unfinished.first.date).not_to be == finished_match.date
    end
  end

  describe "Scope 'average_goal_by_player'" do
    it 'must be precise' do
      FactoryGirl.create(:presence, player_id: player.id, match_id: finished_match.id, goals: 1)
      another_player = FactoryGirl.create(:player)
      FactoryGirl.create(:presence, player_id: another_player.id, match_id: finished_match.id, goals: 3)
      expect(finished_match.average_goal_by_player).to eq(2.0)
    end
  end

  describe "Scope 'find_videos_and_relate'" do
    before do
      date = Date.today
      @video = FactoryGirl.build(:video, date: I18n.l(date))
      @match = FactoryGirl.build(:match, date: I18n.l(date), finished: true)
    end

    it 'relationship must work' do
      @match.videos << @video
      @match.save
      expect(@video.match).to eq(@match)
      expect(@match.videos).to include(@video)
    end

    it 'must link match to existing videos' do
      @video.save
      @match.save
      expect(@video.match).to eq(@match)
      expect(@match.videos).to include(@video)
    end
  end

end
