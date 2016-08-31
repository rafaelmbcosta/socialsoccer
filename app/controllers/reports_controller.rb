class ReportsController < ApplicationController
	def top_strikers
		@season = Season.last
	    @goals = @season.goals
		@matches = @season.matches.size
		@result = @season.top_strikers
		json_result = {id: @season.id, goals: @goals, matches: @matches, players: @result}
		respond_to do |format|
			format.html
			format.json { render json: json_result }
		end
	end

	def matches
		@season = Season.last
		@matches = Match.all.where("season_id = ?", @season.id).sort.reverse
	end

	def match_detail
		@match = Match.find(params["id"])
		@presences = Presence.all.where("match_id = ?", @match.id).sort_by{|p| p.goals}.reverse
	end

	def videos
		@videos = Video.all
	end

	def players
		presences = Presence.where("presence is true").joins(:player).group_by{|presence| presence.player_id}
		presences = presences.collect{|k,v| [Player.find(k), v.size]}
		@presences = presences.sort_by{|a| a[1]}.reverse
	end

	def player
		@best_team = []
		@best_match = nil
		@player = Player.find(params["id"])
		@matches = Presence.all
		@matches_played = @matches.where("player_id = ? and presence is true", @player.id).order('id asc')
		@goals = @matches_played.sum(:goals)
		@goals_match = (@goals/@matches_played.size.to_f).round(2)
		@best_team = @player.best_team(@matches_played)
	end
end