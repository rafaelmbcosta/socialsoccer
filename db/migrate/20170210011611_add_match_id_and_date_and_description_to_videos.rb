class AddMatchIdAndDateAndDescriptionToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :match_id, :integer, default: nil
    add_column :videos, :date, :date, null: false, default: ( Time.now - 1.year )
    add_column :videos, :description, :string, null: false, default: "Social Video"
  end
end
