class AddChurchIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :church, index: true, foreign_key: true
  end
end
