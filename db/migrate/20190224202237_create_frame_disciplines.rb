class CreateFrameDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :frame_disciplines do |t|
      t.integer :frame_id
      t.integer :discipline_id

      t.timestamps
    end
  end
end
