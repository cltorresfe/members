class ChangeTypoAddressField < ActiveRecord::Migration[5.0]
  def change
    rename_column :churches, :adress, :address
    rename_column :members, :adress, :address
  end
end
