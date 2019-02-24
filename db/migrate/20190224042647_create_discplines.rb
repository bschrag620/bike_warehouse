class CreateDiscplines < ActiveRecord::Migration[5.2]
  def change
    create_table :discplines do |t|
      t.string :name

      t.timestamps
    end
  end
end
