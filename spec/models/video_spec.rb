require "rails_helper"

RSpec.describe Video, :type => :model do

  let!(:unfinished_match) { FactoryGirl.create(:match) }
  let!(:finished_match) { FactoryGirl.create(:match, date: Date.new, finished: true) }
  let!(:video_with_match) { FactoryGirl.create(:video,  match_id: finished_match.id) }
  let!(:video) { FactoryGirl.create(:video) }

  describe "Associations" do
    it { should belong_to :match }
  end


  #Service is stubbed (see rails helper)
  describe "Scope 'presence(match_id)'" do
    it "Always return a presence" do
        expect(video_with_match.match_id).to eq(finished_match.id)
    end
  end

  describe "Scope 'presence(match_id)'" do
    it "Don't return a presence" do
        expect(video.match_id).to eq(nil)
    end
  end

end
