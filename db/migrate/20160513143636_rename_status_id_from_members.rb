class RenameStatusIdFromMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column :members, :status_id, :status
  end
end
