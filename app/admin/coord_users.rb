ActiveAdmin.register CoordUser, namespace: :admin do
  menu priority: 3, label: proc {"Coordinators"}

  config.batch_actions = true
  config.scoped_collection_actions_if = -> { true }
  permit_params :email, :password, :password_confirmation, :verified

  scoped_collection_action :verify_coord_users, title: 'Verify Selected New Coordinator Accounts' do
    scoped_collection_records.update_all(verified: true)
  end

  index do
    panel "Coordinators" do
      para "This is the list of ALL COORDINATORS."
    end

    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :verified
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :verified

  show do
    panel "Options" do
      link_to("Go Back To Coordinators", admin_coord_users_path())
    end

    attributes_table do
      row :name
      row :email
      row :reset_password_token
      row :reset_password_sent_at
      row :verified
      row :remember_created_at
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

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
