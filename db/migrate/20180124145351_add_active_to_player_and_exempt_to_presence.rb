class AddActiveToPlayerAndExemptToPresence < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :active, :boolean, default: true
    add_column :presences, :exempt, :boolean, default: false
  end
end
