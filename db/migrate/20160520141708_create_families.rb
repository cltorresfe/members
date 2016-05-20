class CreateFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :families do |t|
      t.string :name
      t.datetime :married_at
      t.string :address
      t.string :phone
      t.string :city
      t.string :country
      t.references :church, foreign_key: true

      t.timestamps
    end
  end
end
