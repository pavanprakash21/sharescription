class AddMedicalRecordsCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :medical_records_count, :integer, null: false, default: 0
  end
end
