class ChangeColumnNameToFirstNameToMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column :members, :name, :first_name
    remove_column :members, :middle_name
  end
end
