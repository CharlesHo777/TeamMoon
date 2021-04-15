
ActiveAdmin.register AdminUser, namespace: :admin do
  menu priority: 2, label: proc {"Administrators"}
  
  permit_params :email, :password, :password_confirmation

  index do
    panel "Administrators" do
      para "This is the list of ALL ADMINISTRATORS."
    end

    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    panel "Options" do
      link_to("Go Back To Administrators", admin_admin_users_path())
    end

    attributes_table do
      row :name
      row :email
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
