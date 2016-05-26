class AddChurchToMinistry < ActiveRecord::Migration[5.0]
  def change
    add_reference :ministries, :church, foreign_key: true
  end
end
