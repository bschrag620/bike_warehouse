class AddTableTransactions < ActiveRecord::Migration[5.2]
  def change
  	create_table :transactions do |t|
  		t.integer :user_id
  		t.integer :transaction_addresses_id
  		
		t.timestamps
  	end
  end
end
