ActiveAdmin.register AdminUser, namespace: :coord do
  menu priority: 2, label: proc {"Administrators"}
  actions :all, :except => [:new, :edit, :destroy]

  permit_params :email, :password, :password_confirmation

  index do
    panel "Administrators" do
      para ""
    end

    selectable_column
    id_column
    column :email
    actions
  end

  filter :email

end
