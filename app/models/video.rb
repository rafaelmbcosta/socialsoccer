class Video < ApplicationRecord
  validates :description, presence: true
  validates :date, presence: true
  validates :url, presence: true
end
