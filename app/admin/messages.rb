ActiveAdmin.register Message, as: 'Message', namespace: :admin do
  menu priority: 7, label: proc {"All Communication Records"}
  actions :all, :except => [:new, :edit]

  index do
    panel "All Communication Records" do
      para "This is a list of ALL MESSAGES on system record, sent by ALL types of system users."
      para "You CANNOT see the content of each message because many (if not most) of these messages are PRIVATE."
      para "To see the content of announcements, please click into the \"Public Announcements\" register page."
      para ""
      para "IMPORTANT:"
      para "For the \"Sender ID\" and \"Recipient ID\" filter, if you're entering a Coordinator's Account ID, enter it as a NEGATIVE NUMBER (e.g. if the Coordinator's ID is 'n', then enter it as '-n')."
      para "If you're entering a Participant's Account ID, enter it as a POSITIVE NUMBER (e.g. if the Participant's ID is 'm', then enter it as 'm'."
    end

    selectable_column
    id_column
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
    column "Recipient Type" do |message|
      if message.recipient_id < 0
        "Coordinator"
      elsif message.recipient_id > 0
        "Participant"
      else
        "(Announcement)"
      end
    end
    column "Recipient ID" do |message|
      if message.recipient_id < 0
        message.recipient_id * (-1)
      else
        message.recipient_id
      end
    end
    column "Recipient" do |message|
      recipient_id = message.recipient_id
      if recipient_id < 0 && CoordUser.exists?(recipient_id * (-1))
        CoordUser.find(recipient_id * (-1)).name
      elsif recipient_id > 0 && Participant.exists?(recipient_id)
        Participant.find(recipient_id).name
      else
      end
    end
    column "Recipient's Email" do |message|
      recipient_id = message.recipient_id
      if recipient_id < 0 && CoordUser.exists?(recipient_id * (-1))
        CoordUser.find(recipient_id * (-1)).email
      elsif recipient_id > 0 && Participant.exists?(recipient_id)
        Participant.find(recipient_id).email
      else
      end
    end
    actions
  end

  filter :sender_id, label: "Sender ID"
  filter :recipient_id, label: "Recipient ID"
  filter :created_at

  show do
    panel "Options" do
      link_to("Go Back To Messages", admin_messages_path())
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
          "(Announcement)"
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
      row "Recipient Type" do |message|
        if message.recipient_id < 0
          "Coordinator"
        elsif message.recipient_id > 0
          "Participant"
        else
          "(Announcement)"
        end
      end
      row "Recipient ID" do |message|
        if message.recipient_id < 0
          message.recipient_id * (-1)
        else
          message.recipient_id
        end
      end
      row "Recipient" do |message|
        recipient_id = message.recipient_id
        if recipient_id < 0 && CoordUser.exists?(recipient_id * (-1))
          CoordUser.find(recipient_id * (-1)).name
        elsif recipient_id > 0 && Participant.exists?(recipient_id)
          Participant.find(recipient_id).name
        else
        end
      end
      row "Recipient's Email" do |message|
        recipient_id = message.recipient_id
        if recipient_id < 0 && CoordUser.exists?(recipient_id * (-1))
          CoordUser.find(recipient_id * (-1)).email
        elsif recipient_id > 0 && Participant.exists?(recipient_id)
          Participant.find(recipient_id).email
        else
        end
      end

    end

  end

end
