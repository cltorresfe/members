ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation, :church_id

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :last_sign_in_at
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :name

  show do
    attributes_table do
      row :email
      row :name
      row :church
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :name
      f.input :church
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
