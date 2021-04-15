class CreateEmailNotifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :email_notifiers do |t|
      t.text :template

      t.timestamps
    end
    add_reference :email_notifiers, :participant, index: true
  end
end
