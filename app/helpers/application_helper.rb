module ApplicationHelper
	def player_name(player)
		name = player.name
		name += " (#{player.nickname})" unless (player.nickname.nil? or player.nickname.blank?)
		return name
	end

	def open_matches
		return Match.unfinished.size
	end
end
