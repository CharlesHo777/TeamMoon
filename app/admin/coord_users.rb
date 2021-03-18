ActiveAdmin.register CoordUser, namespace: :admin do
  menu priority: 3, label: proc {"Coordinators"}

  permit_params :email, :password, :password_confirmation, :verified

  index do
    panel "Coordinators" do
      para "This is the list of ALL COORDINATORS."
    end

    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :verified
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :verified

  form do |f|
    f.object.verified = true
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :verified, label: "Verified (Keep This Box Checked)"
    end
    f.actions
  end

end
