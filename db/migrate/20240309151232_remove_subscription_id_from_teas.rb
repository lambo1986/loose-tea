class RemoveSubscriptionIdFromTeas < ActiveRecord::Migration[7.1]
  def change
    remove_column :teas, :subscription_id, :bigint
  end
end
