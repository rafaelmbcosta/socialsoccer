require 'carrierwave/orm/activerecord'

class Player < ApplicationRecord

  has_many :presences
  has_many :matches, through: :presences
  mount_uploader :avatar, AvatarUploader

  scope :active, -> { where('active is true') }

  def self.presence(player_id, match_id)
    presence = Presence.where("match_id = #{match_id} and player_id = #{player_id}")
    presence.empty? ? (return Presence.new(player_id: player_id, match_id: match_id)) : (return presence.first)
  end

  def confirmed_match(match_id)
    presences = Presence.where("match_id = #{match_id} and player_id = #{self.id} and confirmation is true")
    return !presences.empty?
  end

  def goals_match(match_id)
    presence = Presence.where("match_id = #{match_id} and player_id = #{self.id} and presence is true")
    presence.empty? ? (return 0) : (return presence.first.goals)
  end

  def assists_match(match_id)
    presence = Presence.where("match_id = #{match_id} and player_id = #{self.id} and presence is true")
    presence.empty? ? (return 0) : (return presence.first.assist)
  end

  def played_match(match_id)
    Presence.where("match_id = #{match_id} and player_id = #{self.id} and presence is true")
  end

  def self.players_by_season(season_id)
    season = Season.find(season_id)
    presences = season.presences.where("presence is true").joins(:player).group_by{|presence| presence.player}
    presences = presences.collect{|k,v| { "player" => k, "matches" => v.size}}
    return presences
  end

  def payed_match(match_id)
    presence = Presence.where("match_id = #{match_id} and player_id = #{self.id} and payed is true")
    return !presence.empty?
  end

  def team_played(match_id)
    presence = Presence.where("match_id = #{match_id} and player_id = #{self.id} and presence")
    presence.empty? ? (return nil) : (return presence.first.team_id)
  end

  def best_team(matches)
    record = 0
    worst = 100
    top_team = Array.new
    bad_team = Array.new
    record_match_id = nil
    worst_match_id = nil
    matches.each do |presence|
      #this unless is only here because on our first match nobody recorded the teams
      #highly recommend you to remove this unless match
      unless (presence.match_id == 1)
        team_id = presence.team_id
        if team_id.nil?
          presences = Presence.where("match_id = ? and team_id is null", presence.match.id)
        else
          presences = Presence.where("match_id = ? and team_id = ?", presence.match.id, team_id)
        end
        goals = presences.sum("goals")
        if goals >= record
          record = goals
          top_team = presences.collect{|p| [Player.find(p.player_id), p.goals]}
          record_match_id = presence.match_id
        end
        if goals < worst
          worst = goals
          bad_team = presences.collect{|p| [Player.find(p.player_id), p.goals]}
          worst_match_id = presence.match_id
        end
      end
    end
    return {
      top_goals: record, worst_goals: worst,
      top_team: top_team, bad_team: bad_team,
      best_id: record_match_id, worst_id: worst_match_id
    }
  end
end
