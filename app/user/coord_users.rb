ActiveAdmin.register CoordUser, namespace: :user do
  menu priority: 4, label: proc {"Coordinators"}
  actions :all, :except => [:new, :edit, :destroy]

  action_item :send_message, only: [:show] do
    link_to("Send A Message", new_user_message_path(:message => {:recipient_id => (resource.id * (-1))}))
  end

  index do
    panel "Coordinators" do
      para "This is the list of ALL COORDINATORS."
    end

    selectable_column
    id_column
    column :name
    column :email
    column :verified
    actions
  end

  filter :name
  filter :email
  filter :verified

  show do
    panel "Options" do
      link_to("Go Back To Coordinators", user_coord_users_path())
    end
    attributes_table do
      row :name
      row :email
      row :verified
    end
  end

end
