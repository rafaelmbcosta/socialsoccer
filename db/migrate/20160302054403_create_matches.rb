class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date :date
      t.float :value, null: false, default: 10.0
      t.float :field_value, null: false, default: 150.0
      t.boolean :finished, null: false, default: false
      t.boolean :video, null: false, default: false
      t.string :video_link
      t.string :sumula_link
      t.references :season, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
