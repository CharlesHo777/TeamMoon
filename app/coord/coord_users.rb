ActiveAdmin.register CoordUser, namespace: :coord do
  menu priority: 3, label: proc {"Coordinators"}
  actions :all, :except => [:new, :edit, :destroy]

  permit_params :email, :password, :password_confirmation, :verified

  index do
    panel "Coordinators" do
      para ""
    end

    selectable_column
    id_column
    column :email
    column :verified
    actions
  end

  filter :email
  filter :verified

end
