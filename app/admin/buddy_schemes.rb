ActiveAdmin.register BuddyScheme, namespace: :admin do
  menu priority: 4

  permit_params :name, :year, :capacity, :description

  index do
    panel "Buddy Schemes" do
      para "This is the list of ALL BUDDY SCHEMES."
    end

    selectable_column
    id_column
    column :name
    column :year
    column :capacity
    column :description
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :year
      f.input :capacity
      f.input :description
    end
    f.actions
  end

end
