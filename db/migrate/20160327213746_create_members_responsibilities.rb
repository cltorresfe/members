class CreateMembersResponsibilities < ActiveRecord::Migration
  def change
    create_table :members_responsibilities, :id => false do |t|
    	t.references :member
    	t.references :responsibility
    end
    add_index :members_responsibilities, :member_id
    add_index :members_responsibilities, :responsibility_id
  end

  def self.down
  	drop_table:members_responsibilities
  end
end
