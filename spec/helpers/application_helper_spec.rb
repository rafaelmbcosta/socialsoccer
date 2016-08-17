require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "Scope 'player_name(player)'" do
    it "Should return 'player_name(nickname)' unless nickname is nil" do
    	player = FactoryGirl.create(:player)
    	expect(player_name(player)).to eq("#{player.name} (#{player.nickname})")
    	player.nickname = nil
    	player.save
    	expect(player_name(player)).to eq("#{player.name}")
    end
  end
end