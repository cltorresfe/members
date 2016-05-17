class ChangeTypeStatusOnMember < ActiveRecord::Migration
  def change
    # Esto no aplicaria mas
    # add_reference :members, :status, index: true, foreign_key: true
  end
end
