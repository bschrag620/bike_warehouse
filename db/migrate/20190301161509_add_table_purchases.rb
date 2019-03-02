class AddTablePurchases < ActiveRecord::Migration[5.2]
  def change
  	create_table :purchases do |t|
  		t.integer :user_id
  		t.integer :shipping_address_id
  		t.integer :billing_address_id
  		
		t.timestamps
  	end
  end
end
