ActiveAdmin.register BuddyScheme, namespace: :coord do
  menu priority: 4
  actions :all, :except => [:new, :destroy]

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

end
