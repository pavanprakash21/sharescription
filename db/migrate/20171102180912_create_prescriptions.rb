class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :dosage, null: false, default: ''
      t.string :dosage_unit, null: false, default: ''
      t.boolean :morning, null: false, default: false
      t.boolean :afternoon, null: false, default: false
      t.boolean :night, null: false, default: false
      t.string :time, null: false, default: ''
      t.references :medical_record, type: :uuid, index: true, foreign_key: true

      t.timestamps
    end
  end
end
