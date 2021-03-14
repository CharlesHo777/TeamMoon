ActiveAdmin.register AdminUser do
  menu priority: 4

  permit_params :email, :password, :password_confirmation

  index do
    panel "All Administrators" do
      para "Below is the list of all administrators of the Buddy Scheme system. For the scheme coordinators, click \"Coordinator Users\" on the navigation panel at the top of this page"
    end

    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
