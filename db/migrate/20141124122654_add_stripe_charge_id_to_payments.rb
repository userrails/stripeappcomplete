class AddChargeIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :stripe_charge_id, :string
  end
end
