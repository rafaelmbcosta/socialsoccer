class ReportsController < ApplicationController
	def top_strikers
		@result = Season.update_top_strikers
		respond_to do |format|
			format.html
		end
	end

	def matches
		@matches = Match.all.order(date: :desc).group_by{|m| m.season.number}
	end

	def match_detail
		@match = Match.find(params["id"])
		@presences = Presence.all.where("match_id = ?", @match.id).sort_by{|p| p.goals}.reverse
	end

	def videos
		@videos = Video.all.order('date asc')
	end

	def players
		@season = params["id"] ? Season.find(params["id"]) : Season.last
		@presences = Player.players_by_season(@season.id)
		@presences = @presences.sort_by{|hash| hash["matches"]}.reverse
	end

	def player
		@season = params["season"] ? Season.find(params["season"]) : Season.last
		@best_team = []
		@best_match = nil
		@player = Player.find(params["id"])
		@matches_played = Presence.where("player_id = ? and presence is true", @player.id).joins(:match).where("season_id = ?", @season.id).order('id asc')
		# @matches = Presence.where("season_id = ?",)
		# @matches_played = @matches.where("player_id = ? and presence is true", @player.id).order('id asc')
		@goals = @matches_played.sum(:goals)
		@assist = @matches_played.sum(:assist)
		@goals_match = (@goals/@matches_played.size.to_f).round(2)
		@best_team = @player.best_team(@matches_played)
	end
end
