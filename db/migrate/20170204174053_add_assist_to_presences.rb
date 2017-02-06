class AddAssistToPresences < ActiveRecord::Migration
  def change
    add_column :presences, :assist, :integer, null: false, default: 0
  end
end
