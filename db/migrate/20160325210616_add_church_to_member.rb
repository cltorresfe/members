class AddChurchToMember < ActiveRecord::Migration
  def change
    add_reference :members, :church, index: true, foreign_key: true
  end
end
