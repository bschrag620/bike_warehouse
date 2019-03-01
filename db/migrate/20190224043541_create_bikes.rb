class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.string :frame_id
      t.integer :year
      t.integer :serial
      t.string :components
      t.integer :size
      t.string :part_number
      t.boolean :is_available, :default => true
      t.boolean :in_cart, :default => false
      t.boolean :sold, :default => false
      t.integer :price
      t.string :color
      t.integer :purchase_id

      t.timestamps
    end
  end
end
