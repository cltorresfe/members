class RemoveStatusesTable < ActiveRecord::Migration[5.0]
  def up
    # Remover tabla obsoleta solo en caso que ya exista
    drop_table :statuses if ActiveRecord::Base.connection.table_exists? :statuses
  end

  def down
  end
end
