class DropCustomerSubscriptions < ActiveRecord::Migration[7.1]
  def change
    drop_table :customer_subscriptions
  end
end
