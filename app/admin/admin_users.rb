ActiveAdmin.register AdminUser do
  menu priority: 2, label: proc {"Administrators and Coordinators"}

  permit_params :email, :password, :password_confirmation, :is_administrator, :verified

  index do
    panel "All Administrators and Coordinators" do
      para "Below is the list of ALL system administrators and scheme coordinators. To see ONLY administrators or ONLY coordinators, use the FILTER on the right side of the page."
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
  filter :is_administrator
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|

    panel "Create a new account" do
      para "If you're creating an ADMINISTRATOR account, please MARK the \"is_administrator\" option;"
      para "if you're creating a COORDINATOR account, please keep that option UNMARKED."
    end

    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_administrator
    end
    f.actions
  end

end
