class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.string :manufacturer
      t.string :frame
      t.integer :year
      t.integer :serial
      t.string :components
      t.integer :size
      t.integer :price
      t.string :color

      t.timestamps
    end
  end
end
