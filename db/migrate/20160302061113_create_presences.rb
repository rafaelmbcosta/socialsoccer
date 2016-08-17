class CreatePresences < ActiveRecord::Migration
  def change
    create_table :presences do |t|
      t.references :player, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true
      t.boolean :confirmation, null: false, default: false
      t.boolean :presence, null: false, default: false
      t.boolean :fault, null: false, default: false
      t.boolean :payed, null:false, default: false
      t.integer :goals, null:false, default: 0
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
