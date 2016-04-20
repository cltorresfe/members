class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :ministry, index: true, foreign_key: true
      t.references :responsibility, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
