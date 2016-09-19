class RemoveColumnStatusOnMember < ActiveRecord::Migration
  def change
    remove_column :members, :estado
  end
end
