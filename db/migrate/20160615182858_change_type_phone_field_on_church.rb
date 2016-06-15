class ChangeTypePhoneFieldOnChurch < ActiveRecord::Migration[5.0]
  def change
    change_column :churches, :phone, :string
  end
end
