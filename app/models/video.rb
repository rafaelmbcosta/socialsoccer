class Video < ApplicationRecord
  belongs_to :match

  validates :description, presence: true
  validates :date, presence: true
  validates :url, presence: true
end
