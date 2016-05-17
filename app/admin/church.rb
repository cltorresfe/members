ActiveAdmin.register Church do
  permit_params :name, :address, :email, :phone

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :address
          row :email
          row :phone
        end
      end
      column do
        panel 'Users asociated' do
          table_for church.users do
            column :name do |user|
              link_to user.name, user_path(user)
            end
            column :email
          end
        end
      end
    end
  end

end
