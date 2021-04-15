class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|

      # Coordinators have negative id numbers
      # Participants have positive id numbers
      # Administrators cannot send or receive messages, but they can create a Coordinator account and use that account to send and receive messages

      # Administrators can see the sender, recipient, and timestamp of all messages, regardless of the sender or recipient of each message; however, administrators cannot see the content of those messages

      # Administrators and Coordinators can create announcements, which are special messages that can be seen by all types of users under the "Announcement" register; the sender_id and recipient_id of all announcements are both set to 0

      t.integer :sender_id, null: false, default: 0
      t.integer :recipient_id, null: false, default: 0
      t.text :content, null: false, default: ""

      t.timestamps
    end
  end
end
