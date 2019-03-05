class AddTablePurchases < ActiveRecord::Migration[5.2]
  def change
  	create_table :purchases do |t|
  		t.integer :user_id
  		t.integer :shipping_address_id
  		t.integer :billing_address_id
      t.integer :cc_number
      t.string :purchase_id
      t.float :subtotal
      t.float :tax
      t.float :total
  		t.boolean :in_process, default: true
  		t.boolean :completed, default: false
  		
		t.timestamps
  	end
  end
end
