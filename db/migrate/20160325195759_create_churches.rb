class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :name
      t.string :adress
      t.string :email
      t.integer :phone

      t.timestamps null: false
    end
  end
end
