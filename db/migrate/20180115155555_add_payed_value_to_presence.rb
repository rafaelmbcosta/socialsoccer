class AddPayedValueToPresence < ActiveRecord::Migration[5.0]
  def change
    add_column :presences, :payed_value, :float, default: 0
  end
end
