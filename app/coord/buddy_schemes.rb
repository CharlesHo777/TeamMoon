ActiveAdmin.register BuddyScheme, namespace: :coord do
  menu priority: 4
  permit_params :name, :year, :capacity, :description
  actions :all, :except => [:new, :destroy]
  permit_params :name, :year, :capacity, :description

  controller do
    def delete
      members = Participant.where(buddy_scheme_id: resource.id)
      members.update_all(buddy_scheme_id: -1)
      super
    end
  end

  sidebar "Options", only: [:show, :edit] do
    link_to "View Members Of This Buddy Scheme", coord_buddy_scheme_members_path(resource)
  end

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

  show do
    panel "Options" do
      link_to("Go Back To Buddy Schemes", coord_buddy_schemes_path())
    end
    attributes_table do
      row :name
      row :year
      row :capacity
      row :description
      row :created_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :year, label: "Year (e.g. 2020)"
      f.input :capacity
      f.input :description
    end
    f.actions
  end

end

ActiveAdmin.register Participant, as: 'Member', namespace: :coord do
  belongs_to :buddy_scheme

  config.batch_actions = true
  config.scoped_collection_actions_if = -> { true }
  permit_params :name, :gender, :buddy_scheme_id, :is_mentor, :faculty, :department, :program, :year, :participant_id, :need_special_care, :gender_preference

  batch_action :do_nothing do
  end

  actions :all, :except => [:new, :destroy]

  scope :all, default: true
  scope :not_paired do |participants|
    participants.where(participant_id: -1)
  end

  controller do
    defaults :collection_name => "participants"
  end

  scoped_collection_action :pair_selected, title: 'Automatically Pair Up Selected Users' do
    mentors = scoped_collection_records.where(is_mentor: true)
    unpaired_mentees = scoped_collection_records.where(is_mentor: false).where(participant_id: -1)

    if mentors.count < 1
      flash[:notice] = 'Error: No Mentor Is Selected! Pairing Terminated'
    elsif unpaired_mentees.count < 1
      flash[:notice] = 'Error: No Unpaired Mentee Is Selected! Pairing Terminated'
    else
      while !unpaired_mentees.empty? do
        if mentors.where(participant_id: -1).empty?
          cur_mentor = mentors.order('participant_id DESC').first!
          cur_mentee = unpaired_mentees.first!
          cur_mentee.update(participant_id: cur_mentor.id)
          if cur_mentor.participant_id >= 0
            cur_mentor.update(participant_id: -2)
          elsif cur_mentor.participant_id <= -2
            cur_reverse_buddy_count = cur_mentor.participant_id
            cur_mentor.update(participant_id: (cur_reverse_buddy_count - 1))
          else
            cur_mentor.update(participant_id: cur_mentee.id)
          end
        else
          cur_mentor = mentors.where(participant_id: -1).first!
          cur_mentee = unpaired_mentees.first!
          cur_mentee.update(participant_id: cur_mentor.id)
          cur_mentor.update(participant_id: cur_mentee.id)
        end
        unpaired_mentees = scoped_collection_records.where(is_mentor: false).where(participant_id: -1)
      end
    end
  end

  scoped_collection_action :unpair_selected, title: 'UNPAIR Selected Users' do
    paired_mentors = scoped_collection_records.where(is_mentor: true).where('participant_id != ?', -1)

    while !paired_mentors.empty? do
      cur_mentor = paired_mentors.order('participant_id ASC').first!
      if cur_mentor.participant_id != -1
        Participant.where(is_mentor: false).where(["participant_id = :participant_id", {participant_id: cur_mentor.id}]).update_all(participant_id: -1)
      else

      end
      cur_mentor.update(participant_id: -1)
      paired_mentors = scoped_collection_records.where(is_mentor: true).where('participant_id != ?', -1)
    end

    paired_mentees = scoped_collection_records.where(is_mentor: false).where('participant_id != ?', -1)

    while !paired_mentees.empty? do
      cur_mentee = paired_mentees.first!
      if Participant.where(is_mentor: true).exists?(cur_mentee.participant_id)
        cur_mentor = Participant.where(is_mentor: true).find(cur_mentee.participant_id)
        cur_mentor.update(participant_id: -1)
      else

      end
      cur_mentee.update(participant_id: -1)
      paired_mentees = scoped_collection_records.where(is_mentor: false).where('participant_id != ?', -1)
    end
  end

  scoped_collection_action :remove_from_scheme, title: 'Remove Selected From This Buddy Scheme' do
    scoped_collection_records.update_all(buddy_scheme_id: -1)
  end

  index do
    panel "Options" do
      link_to("Go Back To #{buddy_scheme.name}", "/coord/buddy_schemes/#{buddy_scheme.id}")
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
  filter :email, as: :string

  filter :gender, as: :select, collection: [['Male', 1], ['Female', 2], ['Other', 0]]

  filter :is_mentor, label: "Mentor or Mentee", as: :select, collection: [['Mentor', true], ['Mentee', false]]

  filter :faculty, label: "Faculty", as: :select, collection: Participant.faculties
  filter :department, label: "Department", as: :select, collection: Participant.departments
  filter :program, as: :string
  filter :year, label: "Year", as: :select, collection: Participant.years

  filter :need_special_care, as: :boolean
  filter :gender_preference, as: :select, collection: [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]]

  show do

    panel "Options" do
      link_to("Go Back To Members", coord_buddy_scheme_members_path(BuddyScheme.find(resource.buddy_scheme_id)))
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
      row "Paired Buddy" do |participant|
        Participant.detailed_buddy_map(participant.participant_id)
      end
      row :need_special_care
      row :gender_preference do |participant|
        Participant.gender_preference_map(participant.gender_preference)
      end
      row :created_at
    end

    active_admin_comments
  end

  form do |f|
    f.object.buddy_scheme_id = buddy_scheme.id
    f.inputs do

      f.input :name
      f.input :gender, :label => 'Gender', :as => :select, :collection => [['Other', 0], ['Male', 1], ['Female', 2]], :include_blank => false

      f.input :buddy_scheme_id, :label => 'Choose A Scheme (Or Leave It Blank)', :as => :select, :collection => [['None', -1]] + BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}, :include_blank => false

      f.input :is_mentor, :label => 'Mentor or Mentee', :as => :select, :collection => [['Mentor', true], ['Mentee', false]], :include_blank => false

      f.input :faculty, :label => 'Faculty', :as => :select, :collection => Participant.faculties, :include_blank => false

      f.input :department, :label => 'Department', :as => :select, :collection => Participant.departments, :include_blank => false

      f.input :program
      f.input :year, :label => 'Year (e.g. "1" for Year 1)'

      f.input :need_special_care
      f.input :gender_preference, :as => :select, :collection => [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]], :include_blank => false

    end
    f.actions
  end

end
