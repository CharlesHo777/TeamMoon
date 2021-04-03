ActiveAdmin.register BuddyScheme, namespace: :admin do
  menu priority: 4
  permit_params :name, :year, :capacity, :description

  sidebar "Options", only: [:show, :edit] do
    link_to "View Members Of This Buddy Scheme", admin_buddy_scheme_members_path(resource)
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

ActiveAdmin.register Participant, as: 'Member', namespace: :admin do
  belongs_to :buddy_scheme

  permit_params :name, :kcl_email, :gender, :buddy_scheme_id, :is_mentor, :faculty, :department, :program, :year, :participant_id, :need_special_care, :gender_preference

  actions :all, :except => [:new, :destroy]

  controller do
    defaults :collection_name => "participants"

    def pair_with_a_buddy
      resource.update(participant_id: params[:participant_id])
    end
  end

  action_item :pair_up, only: [:show] do
    link_to 'Pair With A Buddy', '#', :onclick => :pair_with_a_buddy
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

  form do |f|
    f.object.buddy_scheme_id = -1
    f.inputs do

      f.input :name
      f.input :kcl_email

      f.input :gender, :label => 'Gender', :as => :select, :collection => [['Other', 0], ['Male', 1], ['Female', 2]], :include_blank => false

      f.input :buddy_scheme_id, :label => 'Choose A Scheme (Or Leave It Blank)', :as => :select, :collection => [['None', -1]] + BuddyScheme.all.map{|scheme| [scheme.name, scheme.id]}, :include_blank => false

      f.input :is_mentor, :label => 'Mentor or Mentee', :as => :select, :collection => [['Mentor', true], ['Mentee', false]]

      f.input :faculty, :label => 'Faculty', :as => :select, :collection => Participant.faculties

      f.input :department, :label => 'Department', :as => :select, :collection => Participant.departments

      f.input :program
      f.input :year, :label => 'Year (e.g. "1" for Year 1)'

      f.input :need_special_care
      f.input :gender_preference, :as => :select, :collection => [['Any', 0], ['Same Gender', 1], ['Different Gender', 2]]

      f.input :participant_id

    end
    f.actions
  end

  show do

    panel "Options" do
      link_to("Go Back To Members", admin_buddy_scheme_members_path(BuddyScheme.find(resource.buddy_scheme_id)))
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
  end

end

# ActiveAdmin.register Participant, as: 'Non-Member', namespace: :admin do
#   belongs_to :buddy_scheme, :optional => true
#
#   actions :all, :except => [:new, :destroy]
#
#   controller do
#     defaults :collection_name => "participants"
#   end
#
#   scope :not_joined do |participants|
#     participants.where("buddy_scheme_id == ?", -1)
#   end
#
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :kcl_email
#     column "Buddy Scheme" do
#       if BuddyScheme.find(params[:buddy_scheme_id]) != nil
#         BuddyScheme.find(params[:buddy_scheme_id]).name
#       else
#         "None"
#       end
#     end
#     column :is_mentor
#
#     column :department
#     column :program
#     column :year
#     column :participant_id
#     actions
#   end
# end
