class RenameStatusIdFromMembers < ActiveRecord::Migration[5.0]
  def change
    if ActiveRecord::Base.connection.table_exists? :statuses
      rename_column :members, :status_id, :status
    else
      add_column :members, :status, :integer
    end
  end
end
