class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.integer :zip
      t.boolean :default
      t.integer :user_id

      t.timestamps
    end
  end
end
