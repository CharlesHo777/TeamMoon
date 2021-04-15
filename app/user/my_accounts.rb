ActiveAdmin.register Participant, as: 'MyAccount', namespace: :user do
  menu priority: 8
  actions :all, :except => [:new, :destroy]

  permit_params :email, :name, :gender, :buddy_scheme_id, :is_mentor, :faculty, :department, :program, :year, :need_special_care, :gender_preference

  controller do

  end

  scope :my_account, default: true do |participants|
    participants.where('id == ?', current_participant.id)
  end

  index do
    panel "YOUR ACCOUNT" do
      para "This page shows YOUR ACCOUNT RECORD. To VIEW and EDIT the DETAILS of your account, click \"View\" at your record BELOW."
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

    column "Paired Buddy" do |participant|
      Participant.buddy_map(participant.participant_id)
    end

    column :need_special_care
    column :gender_preference do |participant|
      Participant.gender_preference_map(participant.gender_preference)
    end
    actions
  end

  filter :name

  show do
    panel "Options" do
      link_to("Go Back", user_my_accounts_path())
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
      row :updated_at
    end

  end

  form do |f|
    f.inputs do
      f.input :email

      f.input :name
      f.input :gender, :label => 'Gender', :as => :select, :collection => [['Other', 0], ['Male', 1], ['Female', 2]], :include_blank => false

      f.input :buddy_scheme_id, :label => 'Choose A Scheme (Or Leave It Blank)', :as => :select, :collection => [['None', -1]] + BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}, :include_blank => false

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
