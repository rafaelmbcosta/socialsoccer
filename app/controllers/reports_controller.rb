class ReportsController < ApplicationController
	def top_strikers
		@season = params["id"] ? Season.find(params["id"]) : Season.last
	  @goals = @season.goals
		@matches = @season.matches.size
		@result = @season.top_strikers
		respond_to do |format|
			format.html
			format.json { render json: @result.collect{ |ts| { _id: ts["id"], name: ts["name"], goals: ts["goals"] }} }
		end
	end

	def seasons
		@seasons = Season.all.collect{|season| { _id: season.id, number: season.number}}
		respond_to do |format|
			format.json { render json: @seasons }
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
