ActiveAdmin.register Participant, namespace: :admin do
  menu priority: 5

  permit_params :name, :kcl_email, :is_mentor, :department, :program, :year, :buddy

  # controller do
  #   def participant_params
  #     params.require(:participant).permit(:name, :kcl_email, :is_mentor, :department, :program, :year, :buddy)
  #   end
  # end

  index do
    panel "Participants" do
      para "This is the list of ALL PARTICIPANTS registered to take part in a buddy scheme."
      para "To see ONLY MENTORS, use the FILTER and choose \"Yes\" for the \"IS MENTOR\" option."
      para "To see ONLY MENTEES, use the FILTER and choose \"No\" for the \"IS MENTOR\" option."
    end

    selectable_column
    id_column
    column :name
    column :kcl_email
    column :scheme_id
    column :is_mentor

    column :department
    column :program
    column :year
    column :buddy
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :kcl_email
      f.input :is_mentor
      f.input :department
      f.input :program
      f.input :year
      f.input :buddy
    end
    f.actions
  end

end
