class Match < ApplicationRecord
  has_many :presences
  belongs_to :season
  mount_uploader :sumula_link, SumulaUploader

  after_save :find_videos_and_relate

  def self.unfinished
    return Match.all.where("finished is false")
  end

  def average_goal_by_player
  	presences = self.presences
  	goals = presences.sum("goals")
  	return (goals/presences.size.to_f).round(2)
  end

  def find_videos_and_relate
    videos = Video.where(date: self.date)
    unless videos.blank?
      Video.transaction do
        videos.each do |video|
          video.match_id = self.id
          video.save
        end#end each
      end#end transaction
    end#end unless
  end

end
