class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :sender, type: :uuid, index: true, polymorphic: true
      t.references :recepient, type: :uuid, index: true, polymorphic: true
      t.string :action, null: false, default: ''

      t.timestamps
    end
  end
end
