class Match < ActiveRecord::Base
  
  has_many :presences
  belongs_to :season

  def self.unfinished
    return Match.all.where("finished is false")
  end

  def average_goal_by_player
  	presences = self.presences
  	goals = presences.sum("goals")
  	return (goals/presences.size.to_f).round(2)
  end
end
