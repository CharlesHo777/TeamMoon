ActiveAdmin.register BuddyScheme, namespace: :coord do
  menu priority: 4
  permit_params :name, :year, :capacity, :description
  actions :all, :except => [:new, :destroy]

  sidebar "Options", only: [:show, :edit] do
    ul do
      li link_to "View Members of This Buddy Scheme", admin_buddy_scheme_members_path(resource)
    end
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

end

ActiveAdmin.register Participant, as: 'Member', namespace: :coord do
  belongs_to :buddy_scheme
  actions :all, :except => [:new, :destroy]

  controller do
    defaults :collection_name => "participants"
  end

  index do
    selectable_column
    id_column
    column :name
    column :kcl_email
    column :gender do |participant|
      Participant.gender_map(participant.gender)
    end

    column :is_mentor

    column :faculty
    column :department
    column :program
    column :year

    column :participant_id
    column :need_special_care
    column :gender_preference do |participant|
      Participant.gender_preference_map(participant.gender_preference)
    end
    actions
  end

  filter :name, as: :string
  filter :kcl_email, as: :string

  filter :gender, as: :select, collection: [['Male', 1], ['Female', 2], ['Other', 0]]

  filter :is_mentor, label: "Mentor or Mentee", as: :select, collection: [['Mentor', true], ['Mentee', false]]

  filter :faculty, label: "Faculty", as: :select, collection: Participant.faculties
  filter :department, label: "Department", as: :select, collection: Participant.departments
  filter :program, as: :string
  filter :year, label: "Year", as: :select, collection: Participant.years

  filter :need_special_care, as: :boolean
  filter :gender_preference, as: :select, collection: [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]]

  show do
    attributes_table do
      row :name
      row :kcl_email
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
      row :participant_id
      row :need_special_care
      row :gender_preference do |participant|
        Participant.gender_preference_map(participant.gender_preference)
      end
    end
  end

end
