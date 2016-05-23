class ChangeTypePhoneFieldOnMember < ActiveRecord::Migration[5.0]
  def change
    change_column :members, :phone, :string
  end
end
