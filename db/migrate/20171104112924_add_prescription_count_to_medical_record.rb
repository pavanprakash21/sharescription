class AddPrescriptionCountToMedicalRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :medical_records, :prescriptions_count, :integer, null: false, default: 0
  end
end
