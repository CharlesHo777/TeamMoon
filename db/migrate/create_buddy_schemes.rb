class CreateBuddySchemes < ActiveRecord::Migration[6.0]
  def change
    create_table :buddy_schemes do |t|
      t.string :name
      t.integer :year
      t.integer :capacity
      t.text :description

      t.timestamps
    end
  end
end
