class CreateMedicalRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_records, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.text :notes
      t.references :user, type: :uuid, index: true, foreign_key: true

      t.timestamps
    end
    add_index :medical_records, :name, unique: true
  end
end
