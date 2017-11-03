class CreateShareRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :share_records, id: :uuid do |t|
      t.boolean :shared, null: false, default: false
      t.references :user, type: :uuid, index: true, foreign_key: true
      t.references :medical_record, type: :uuid, index: true, foreign_key: true
      t.references :shareable, type: :uuid, index: true, polymorphic: true

      t.timestamps
    end
    add_index :share_records, :shared, where: :shared
  end
end
