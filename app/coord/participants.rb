ActiveAdmin.register Participant, namespace: :coord do
  menu priority: 5

  config.batch_actions = true
  config.scoped_collection_actions_if = -> { true }
  permit_params :name, :kcl_email, :gender, :buddy_scheme_id, :is_mentor, :faculty, :department, :program, :year, :participant_id, :need_special_care, :gender_preference

  # controller do
  #   def participant_params
  #     params.require(:participant).permit(:name, :kcl_email, :is_mentor, :department, :program, :year, :buddy)
  #   end
  # end

  scope :all, default: true
  scope :not_in_a_buddy_scheme do |participants|
    participants.where("buddy_scheme_id <= ?", 0)
  end

  scoped_collection_action :scoped_collection_update, title: 'Add Selected To A Buddy Scheme', form: -> do
    {
      buddy_scheme_id: BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}
    }
  end
  scoped_collection_action :remove_from_buddy_scheme, title: 'Remove From Buddy Scheme' do
    scoped_collection_records.update_all(buddy_scheme_id: -1)
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

  filter :buddy_scheme_id, label: "Buddy Scheme", as: :select, collection: proc {BuddyScheme.all}
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

  form do |f|
    f.inputs do

      f.input :name
      f.input :kcl_email

      f.input :gender, :label => 'Gender', :as => :select, :collection => [['Male', 1], ['Female', 2], ['Other', 0]]

      f.input :buddy_scheme_id, :label => 'Choose A Scheme (Or Leave It Blank)', :as => :select, :collection => BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}

      f.input :is_mentor, :label => 'Mentor or Mentee', :as => :select, :collection => [['Mentor', true], ['Mentee', false]]

      f.input :faculty, :label => 'Faculty', :as => :select, :collection => Participant.faculties

      f.input :department, :label => 'Department', :as => :select, :collection => Participant.departments

      f.input :program
      f.input :year, :label => 'Year (e.g. "1" for Year 1)'

      f.input :need_special_care
      f.input :gender_preference, :as => :select, :collection => [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]]

      # f.input :participant_id

    end
    f.actions
  end

end