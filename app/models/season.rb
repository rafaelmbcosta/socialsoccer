class Season < ActiveRecord::Base
	has_many :matches
	has_many :presences, through: :matches

	def top_strikers
		resultado = Array.new
		presences = self.presences.where("goals > 0").group_by{|presence| presence.player_id}
		presences.each do |player_id, presence_array|
			player = Hash.new
			p = Player.find(player_id)
			player["id"] = p.id
			player["name"] = p.name
			player["name"] += " (#{p.nickname})" unless (p.nickname.nil? or p.nickname.blank?)
			soma = 0
			presence_array.each do |presence|
				soma += presence.goals
			end
			player["goals"] = soma
			resultado << player
		end
		return resultado.sort_by{|r| r["goals"]}.reverse
	end

	def goals
		presences = self.presences.collect{|p| p.goals}.sum
		return presences
	end
end
