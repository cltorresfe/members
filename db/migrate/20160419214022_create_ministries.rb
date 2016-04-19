class CreateMinistries < ActiveRecord::Migration
  def change
    create_table :ministries do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
