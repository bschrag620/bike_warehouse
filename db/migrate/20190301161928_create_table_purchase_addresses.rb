class CreateTablePurchaseAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_addresses do |t|
      t.integer :purchase_id
      t.integer :address_id
    end
  end
end
