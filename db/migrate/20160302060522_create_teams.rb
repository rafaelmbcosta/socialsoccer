class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string  :color, null: false
      t.string  :rgb, null: false
      t.integer :code

      t.timestamps null: false
    end
  end
end
