ActiveAdmin.register Message, as: 'Message', namespace: :coord do
  menu priority: 6, label: proc {"Private Messages"}
  actions :all, :except => [:edit]
  permit_params :sender_id, :recipient_id, :content

  scope :all_messages, default: true do |messages|
    messages.where('recipient_id == ?', (-1) * current_coord_user.id)
  end
  scope :from_coordinators do |messages|
    messages.where('recipient_id == ?', (-1) * current_coord_user.id).where('sender_id < ?', 0)
  end
  scope :from_participants do |messages|
    messages.where('recipient_id == ?', (-1) * current_coord_user.id).where('sender_id > ?', 0)
  end

  action_item :reply_to_sender, only: [:show] do
    link_to("Reply To This Sender", new_coord_message_path(:message => {:recipient_id => resource.sender_id}))
  end

  index do
    panel "IMPORTANT!" do
      para "For the \"Sender ID\" filter, if you're entering a Coordinator's Account ID, enter it as a NEGATIVE NUMBER (e.g. if the Coordinator's ID is 'n', then enter it as '-n')."
      para "If you're entering a Participant's Account ID, enter it as a POSITIVE NUMBER (e.g. if the Participant's ID is 'm', then enter it as 'm'."
    end

    selectable_column
    column "Sender Type" do |message|
      if message.sender_id < 0
        "Coordinator"
      elsif message.sender_id > 0
        "Participant"
      else
        "(Announcement)"
      end
    end
    column "Sender ID" do |message|
      if message.sender_id < 0
        message.sender_id * (-1)
      else
        message.sender_id
      end
    end
    column "Sender" do |message|
      sender_id = message.sender_id
      if sender_id < 0 && CoordUser.exists?(sender_id * (-1))
        CoordUser.find(sender_id * (-1)).name
      elsif sender_id > 0 && Participant.exists?(sender_id)
        Participant.find(sender_id).name
      else
      end
    end
    column "Sender's Email" do |message|
      sender_id = message.sender_id
      if sender_id < 0 && CoordUser.exists?(sender_id * (-1))
        CoordUser.find(sender_id * (-1)).email
      elsif sender_id > 0 && Participant.exists?(sender_id)
        Participant.find(sender_id).email
      else
      end
    end
    column :content do |message|
      message.content.truncate 50
    end
    column :created_at
    actions
  end

  filter :sender_id, label: "Sender ID"
  filter :created_at

  form do |f|
    f.object.sender_id = current_coord_user.id * (-1)
    f.inputs do
      f.input :recipient_id, :label => 'Choose A Recipient', :as => :select, :collection => CoordUser.all.map{|coord| ["#{coord.name}, Coord, #{coord.email}", coord.id * (-1)]} + Participant.all.map{|user| ["#{user.name}, User, #{user.email}", user.id]}, :include_blank => false

      f.input :sender_id, :as => :select, :collection => [[current_coord_user.name, current_coord_user.id * (-1)]], :include_blank => false
      f.input :content
    end
    f.actions
  end

  show do
    panel "Options" do
      link_to("Go Back To Messages", coord_messages_path())
    end

    attributes_table do

      row "Sender Type" do |message|
        if message.sender_id < 0
          "Coordinator"
        elsif message.sender_id > 0
          "Participant"
        else
          "(Announcement)"
        end
      end
      row "Sender ID" do |message|
        if message.sender_id < 0
          message.sender_id * (-1)
        else
          message.sender_id
        end
      end
      row "Sender" do |message|
        sender_id = message.sender_id
        if sender_id < 0 && CoordUser.exists?(sender_id * (-1))
          CoordUser.find(sender_id * (-1)).name
        elsif sender_id > 0 && Participant.exists?(sender_id)
          Participant.find(sender_id).name
        else
        end
      end
      row "Sender's Email" do |message|
        sender_id = message.sender_id
        if sender_id < 0 && CoordUser.exists?(sender_id * (-1))
          CoordUser.find(sender_id * (-1)).email
        elsif sender_id > 0 && Participant.exists?(sender_id)
          Participant.find(sender_id).email
        else
        end
      end
      row :content
      row :created_at

    end

  end

end
