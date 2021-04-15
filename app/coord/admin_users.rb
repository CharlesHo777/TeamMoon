ActiveAdmin.register AdminUser, namespace: :coord do
  menu priority: 2, label: proc {"Administrators"}
  actions :all, :except => [:new, :edit, :destroy]

  index do
    panel "Administrators" do
      para "This is the list of ALL ADMINISTRATORS."
    end

    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  filter :name
  filter :email

  show do
    panel "Options" do
      link_to("Go Back To Administrators", coord_admin_users_path())
    end
    attributes_table do
      row :name
      row :email
    end
    active_admin_comments
  end

end
