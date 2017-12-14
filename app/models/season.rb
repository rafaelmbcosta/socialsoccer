class Season < ApplicationRecord
	has_many :matches
	has_many :presences, through: :matches

	def self.update_top_strikers
    top_strikers = Hash.new
    Season.all.order('number desc').each do |season|
  		resultado = Array.new
  		presences = season.presences.where("goals > 0 or assist > 0").group_by{|presence| presence.player_id}
  		presences.each do |player_id, presence_array|
  			player = Hash.new
  			p = Player.find(player_id)
  			player["id"] = p.id
  			player["name"] = p.name
  			player["avatar"] = p.avatar.url
  			player["name"] += " (#{p.nickname})" unless (p.nickname.nil? or p.nickname.blank?)
  			soma = 0
  			assists = 0
  			presence_array.each do |presence|
  				soma += presence.goals
  				assists += presence.assist
  			end
  			player["goals"] = soma
  			player["assist"] = assists
  			resultado << player
  		end
      top_strikers[season.number.to_s] = resultado.sort_by{|r| [r["goals"], r["assist"]]}.reverse
    end
    return top_strikers
	end

	def goals
		presences = self.presences.collect{|p| p.goals}.sum
		return presences
	end
end
