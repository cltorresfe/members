class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :member, foreign_key: true
      t.references :ministry, foreign_key: true
      t.datetime :attendance_date
      t.boolean :present

      t.timestamps
    end
  end
end
