class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.integer :zip
      t.boolean :is_shipping, :default => false
      t.boolean :is_billing, :default => false
      t.boolean :default_shipping, :default => false
      t.boolean :default_billing, :default => false
      t.integer :purchase_addresses_id

      t.timestamps
    end
  end
end
