class AddTableBikeDisciplines < ActiveRecord::Migration[5.2]
  def change
  	create_table :bike_disciplines do |t|
  		t.integer :bike_id
  		t.integer :discipline_id
  	end
  end
end
