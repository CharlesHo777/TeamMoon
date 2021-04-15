ActiveAdmin.register Message, as: 'Announcement', namespace: :user do
  menu priority: 7, label: proc {"Public Announcements"}
  actions :all, :except => [:new, :edit, :destroy]

  scope :announcements, default: true do |messages|
    messages.where('sender_id == ?', 0)
  end

  index do
    selectable_column
    column :content do |message|
      message.content.truncate 100
    end
    actions
  end

  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :content
      row :created_at
      row :updated_at
    end
  end

end
