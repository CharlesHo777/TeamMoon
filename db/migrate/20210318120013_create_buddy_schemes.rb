class CreateBuddySchemes < ActiveRecord::Migration[6.0]
  def change
    create_table :buddy_schemes do |t|
      
      t.string :name, null: false, default: ""
      t.integer :year, null: false, default: 0
      t.integer :capacity, null: false, default: 9999
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
