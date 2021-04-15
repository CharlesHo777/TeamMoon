ActiveAdmin.register BuddyScheme, namespace: :user do
  menu priority: 2
  actions :all, :except => [:new, :edit, :destroy]

  sidebar "Options", only: [:show, :edit] do
    link_to "View Members Of This Buddy Scheme", user_buddy_scheme_members_path(resource)
  end

  index do
    panel "Buddy Schemes" do
      para "This is the list of ALL BUDDY SCHEMES."
    end

    selectable_column
    id_column
    column :name
    column :year
    column :capacity
    column :description do |buddy_scheme|
      buddy_scheme.description.truncate 20
    end
    actions
  end

  filter :name
  filter :year

  show do
    panel "Options" do
      link_to("Go Back To Buddy Schemes", user_buddy_schemes_path())
    end
    attributes_table do
      row :name
      row :year
      row :capacity
      row :description
    end
  end

end

ActiveAdmin.register Participant, as: 'Member', namespace: :user do
  belongs_to :buddy_scheme

  actions :all, :except => [:new, :edit, :destroy]

  scope :all, default: true

  controller do
    defaults :collection_name => "participants"
  end

  index do
    panel "Options" do
      link_to("Go Back To #{buddy_scheme.name}", "/user/buddy_schemes/#{buddy_scheme.id}")
    end

    selectable_column
    id_column
    column :name
    column :email
    column :gender do |participant|
      Participant.gender_map(participant.gender)
    end

    column :is_mentor

    column :faculty
    column :department
    column :program do |participant|
      participant.program.truncate 20
    end
    column :year

    actions
  end

  filter :name, as: :string
  filter :email, as: :string

  filter :gender, as: :select, collection: [['Male', 1], ['Female', 2], ['Other', 0]]

  filter :is_mentor, label: "Mentor or Mentee", as: :select, collection: [['Mentor', true], ['Mentee', false]]

  filter :faculty, label: "Faculty", as: :select, collection: Participant.faculties
  filter :department, label: "Department", as: :select, collection: Participant.departments
  filter :program, as: :string
  filter :year, label: "Year", as: :select, collection: Participant.years

  show do

    panel "Options" do
      link_to("Go Back To Members", user_buddy_scheme_members_path(BuddyScheme.find(resource.buddy_scheme_id)))
    end

    attributes_table do
      row :name
      row :email
      row :gender do |participant|
        Participant.gender_map(participant.gender)
      end
      row :buddy_scheme_id do |participant|
        Participant.buddy_scheme_map(participant.buddy_scheme_id)
      end
      row :is_mentor
      row :faculty
      row :department
      row :program
      row :year
    end

  end

end
