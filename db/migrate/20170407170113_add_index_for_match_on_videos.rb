class AddIndexForMatchOnVideos < ActiveRecord::Migration[5.0]
  def change
      add_index "videos", ["match_id"], name: "index_videos_on_match_id", using: :btree
      add_foreign_key :videos, :matches
  end
end
