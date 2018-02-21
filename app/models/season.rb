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

  def self.financial_report
    seasons = Season.where("number >= 2018")
    report = []
    seasons.each do |season|
      season_data = { "season" => season}
      season_data["matches"] = season.matches.count
      season_data["to_pay"] = season.matches.collect{ |m| m.field_value }.inject(0){ |x, sum| x + sum }
      season_data["received"] = season.presences.collect{ |p| p.payed_value }.inject(0){ |x, sum| x + sum }
      season_data["balance"] = season_data["received"] - season_data["to_pay"]
      report << season_data
    end
    report
  end

  def self.balance_report
    seasons = Season.where("number >= 2018")
    players = Player.all
    report = []
    seasons.each do |season|
      balance_season = { season: season, players: []}
      season.presences.where("presence is true").group_by{ |m| m.player }.each do |player, presences|
        player_season = Hash.new
        player_season[:player] = player
        player_season[:to_pay] = 0
        player_season[:payed] = 0
        player_season[:exempt_count] = 0
        player_season[:matches] = presence.count
        presences.each do |presence|
          player_season[:exempt_count] += 1 if presence.exempt
          player_season[:to_pay] += presence.match.value
          player_season[:payed] += presence.payed_value
        end
        balance_season[:players] << player_season
      end # season_presences
      report << balance_season
    end # season
    report
  end
end
