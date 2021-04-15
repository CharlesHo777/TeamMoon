class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|

      t.string :name, null: false, default: ""

      # Gender: 0 for other/unspecified
      # 1 for male; 2 for female
      t.integer :gender, null: false, default: 0

      t.integer :buddy_scheme_id, null: false, default: -1
      t.boolean :is_mentor, null: false, default: false

      t.string :faculty, null: false, default: ""
      t.string :department, null: false, default: ""
      t.string :program, null: false, default: ""
      t.integer :year, null: false, default: 0

      t.integer :participant_id, null: false, default: -1

      t.boolean :need_special_care, null: false, default: false
      # Participant's gender preference for buddy pairing
      # 0 for any, 1 for same gender, 2 for different gender
      t.integer :gender_preference, null: false, default: 0

      t.timestamps
    end
  end
end
