class Match < ApplicationRecord
  has_many :presences
  has_many :videos, autosave: true
  belongs_to :season

  mount_uploader :sumula_link, SumulaUploader

  validates :date, presence: true

  def self.unfinished
    return Match.all.where("finished is false")
  end

  def average_goal_by_player
  	presences = self.presences
  	goals = presences.sum("goals")
  	return (goals/presences.size.to_f).round(2)
  end

end
