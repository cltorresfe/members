class AddChurchToResponsibility < ActiveRecord::Migration[5.0]
  def change
    add_reference :responsibilities, :church, foreign_key: true
  end
end
