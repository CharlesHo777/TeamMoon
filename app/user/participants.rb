ActiveAdmin.register Participant, namespace: :user do
  menu priority: 3
  actions :all, :except => [:new, :edit, :destroy]

  controller do

  end

  scope :all, default: true

  action_item :send_message, only: [:show] do
    link_to("Send A Message", new_user_message_path(:message => {:recipient_id => resource.id}))
  end

  index do
    panel "Participants" do
      para "This is the list of ALL PARTICIPANTS registered to take part in a buddy scheme."
      para "\"YES\" under the \"Is Mentor\" column means that the participant is a MENTOR."
      para "\"NO\" under the \"Is Mentor\" column means that the participant is a MENTEE."
    end

    selectable_column
    id_column
    column :name
    column :email
    column :gender do |participant|
      Participant.gender_map(participant.gender)
    end

    column "Buddy Scheme" do |participant|
      Participant.buddy_scheme_map(participant.buddy_scheme_id)
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

  filter :buddy_scheme_id, label: "Buddy Scheme", as: :select, collection: proc {BuddyScheme.all}
  filter :is_mentor, label: "Mentor or Mentee", as: :select, collection: [['Mentor', true], ['Mentee', false]]

  filter :faculty, label: "Faculty", as: :select, collection: Participant.faculties
  filter :department, label: "Department", as: :select, collection: Participant.departments
  filter :program, as: :string
  filter :year, label: "Year", as: :select, collection: Participant.years

  show do
    panel "Options" do
      link_to("Go Back To Participants", user_participants_path())
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
      row :created_at
    end

  end

end
