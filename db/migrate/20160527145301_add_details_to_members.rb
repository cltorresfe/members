class AddDetailsToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :run, :string
    add_column :members, :last_name, :string
    add_column :members, :middle_name, :string
    add_column :members, :gender, :boolean
    add_column :members, :city, :string
    add_column :members, :country, :string
    add_column :members, :testimony, :text
    add_column :members, :facebook, :string
    add_column :members, :twitter, :string
    add_column :members, :skype, :string
    add_column :members, :birth_date, :datetime
    add_column :members, :baptism_date, :datetime
    add_column :members, :membership_date, :datetime
    add_column :members, :discipline_date, :datetime
    add_column :members, :transfer_date, :datetime

  end
end
