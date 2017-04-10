class Video < ApplicationRecord
  belongs_to :match, autosave: true
  validates :description, presence: true
  validates :date, presence: true
  validates :url, presence: true
  before_save :set_match_id

  def set_match_id
    match = Match.where("date = ?", self.date).last
    self.match_id = match.id unless match.nil?
  end
  
end
