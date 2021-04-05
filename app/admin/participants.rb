ActiveAdmin.register Participant, namespace: :admin do
  menu priority: 5

  config.batch_actions = true
  config.scoped_collection_actions_if = -> { true }
  permit_params :name, :kcl_email, :gender, :buddy_scheme_id, :is_mentor, :faculty, :department, :program, :year, :participant_id, :need_special_care, :gender_preference

  controller do

  end

  scope :all, default: true
  scope :not_in_a_buddy_scheme do |participants|
    participants.where('buddy_scheme_id <= ?', 0)
  end

  scoped_collection_action :scoped_collection_update, title: 'Add Selected To A Buddy Scheme', form: -> do
    {
      buddy_scheme_id: BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}
    }
  end
  scoped_collection_action :remove_from_buddy_scheme, title: 'Remove From Buddy Scheme' do
    scoped_collection_records.update_all(buddy_scheme_id: -1)
  end

  sidebar "Options", only: [:show, :edit], :if => proc {resource.is_mentor} do
    ul do
      li link_to "View Paired Mentee/Mentees Of This Mentor", admin_participant_buddies_path(resource)
    end
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
    column :kcl_email
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

    column "Paired Buddy" do |participant|
      Participant.buddy_map(participant.participant_id)
    end

    column :need_special_care
    column :gender_preference do |participant|
      Participant.gender_preference_map(participant.gender_preference)
    end
    actions
  end

  filter :name, as: :string
  filter :kcl_email, as: :string

  filter :gender, as: :select, collection: [['Male', 1], ['Female', 2], ['Other', 0]]

  filter :buddy_scheme_id, label: "Buddy Scheme", as: :select, collection: proc {BuddyScheme.all}
  filter :is_mentor, label: "Mentor or Mentee", as: :select, collection: [['Mentor', true], ['Mentee', false]]

  filter :faculty, label: "Faculty", as: :select, collection: Participant.faculties
  filter :department, label: "Department", as: :select, collection: Participant.departments
  filter :program, as: :string
  filter :year, label: "Year", as: :select, collection: Participant.years

  filter :need_special_care, as: :boolean
  filter :gender_preference, as: :select, collection: [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]]

  show do
    panel "Options" do
      link_to("Go Back To Participants", admin_participants_path())
    end

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
      row :participant_id do |participant|
        Participant.buddy_map(participant.participant_id)
      end
      row :need_special_care
      row :gender_preference do |participant|
        Participant.gender_preference_map(participant.gender_preference)
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do

      f.input :name
      f.input :kcl_email

      f.input :gender, :label => 'Gender', :as => :select, :collection => [['Other', 0], ['Male', 1], ['Female', 2]], :include_blank => false

      f.input :buddy_scheme_id, :label => 'Choose A Scheme (Or Leave It Blank)', :as => :select, :collection => [['None', -1]] + BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}, :include_blank => false

      f.input :is_mentor, :label => 'Mentor or Mentee', :as => :select, :collection => [['Mentor', true], ['Mentee', false]], :include_blank => false

      f.input :faculty, :label => 'Faculty', :as => :select, :collection => Participant.faculties, :include_blank => false

      f.input :department, :label => 'Department', :as => :select, :collection => Participant.departments, :include_blank => false

      f.input :program
      f.input :year, :label => 'Year (e.g. "1" for Year 1)'

      f.input :need_special_care
      f.input :gender_preference, :as => :select, :collection => [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]], :include_blank => false

      f.input :participant_id

    end
    f.actions
  end

end

ActiveAdmin.register Participant, as: 'Buddy', namespace: :admin do
  belongs_to :participant do |participant|
    participant.participant_id
  end
  actions :all, :except => [:new, :destroy]

  controller do
    defaults :collection_name => "participants"
  end

  index do
    panel "Options" do
      link_to("Go Back To #{participant.name}", "/admin/participants/#{participant.id}")
    end

    selectable_column
    id_column
    column :name
    column :kcl_email
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

    column "Paired Buddy" do |participant|
      Participant.buddy_map(participant.participant_id)
    end

    column :need_special_care
    column :gender_preference do |participant|
      Participant.gender_preference_map(participant.gender_preference)
    end
    actions
  end

  show do
    panel "Options" do
      link_to("Go Back To Buddies", admin_participant_buddies_path(Participant.find(resource.participant_id)))
    end

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

    active_admin_comments
  end

end
