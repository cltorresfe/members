class AddDetailsToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :run, :string
    add_column :members, :last_name, :string
    add_column :members, :middle_name, :string
    add_column :members, :sexo, :boolean
    add_column :members, :city, :string
    add_column :members, :country, :string
    add_column :members, :birthdate, :datetime
    add_column :members, :testimony, :text
    add_column :members, :baptismdate, :datetime
    add_column :members, :membershipdate, :datetime
    add_column :members, :disciplinedate, :datetime
    add_column :members, :transferdate, :datetime
    add_column :members, :facebook, :string
    add_column :members, :twitter, :string
    add_column :members, :skype, :string
  end
end
