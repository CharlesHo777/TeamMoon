class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :kcl_email

      t.integer :scheme_id
      t.boolean :is_mentor

      t.string :department
      t.string :program
      t.integer :year

      t.string :buddy

      t.timestamps
    end
  end
end
