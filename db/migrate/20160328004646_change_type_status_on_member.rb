class ChangeTypeStatusOnMember < ActiveRecord::Migration
  def change
    add_reference :members, :status, index: true, foreign_key: true
  end
end
