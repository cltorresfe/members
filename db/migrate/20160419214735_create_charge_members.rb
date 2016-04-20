class CreateChargeMembers < ActiveRecord::Migration
  def change
    create_table :charge_members do |t|
      t.references :charge, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
