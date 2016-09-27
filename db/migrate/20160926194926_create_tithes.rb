class CreateTithes < ActiveRecord::Migration[5.0]
  def change
    create_table :tithes do |t|
      t.datetime :handed_at
      t.decimal :quantity
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
