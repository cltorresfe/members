class AddAdministrativeToResponsibility < ActiveRecord::Migration[5.0]
  def change
    add_column :responsibilities, :administrative, :boolean, default: false
  end
end
