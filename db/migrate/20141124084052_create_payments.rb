class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :amount
      t.string :stripe_card_token
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
