ActiveAdmin.register Participant, as: 'Buddy', namespace: :user do
  menu priority: 5
  actions :all, :except => [:new, :edit, :destroy]

  controller do

  end

  action_item :send_message, only: [:show] do
    link_to("Send A Message", new_user_message_path(:message => {:recipient_id => resource.id}))
  end

  scope :buddies, default: true do |participants|
    if current_participant.is_mentor?
      participants.where('participant_id == ?', current_participant.id)
    else
      participants.where('id == ?', current_participant.participant_id)
    end
  end

  index do
    panel "Buddy (or Buddies) Paired With You" do
      para "You are paired with the following student (or students)."
      para "If you are a Mentor, then you may be paired with multiple Mentees."
      para "To send a message to a buddy, click \"View\" at his/her record and click \"Send Message\" on the top right corner."
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
