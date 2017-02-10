class Video < ActiveRecord::Base
  validates :description, presence: true
  validates :date, presence: true
  validates :url, presence: true
end
