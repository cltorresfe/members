class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :adress
      t.string :email
      t.integer :phone
      t.string :estado

      t.timestamps null: false
    end
  end
end
