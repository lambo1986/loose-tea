class AddSubscriptionIdToTeas < ActiveRecord::Migration[7.1]
  def change
    add_reference :teas, :subscription, null: false, foreign_key: true
  end
end
