class AddMedicalRecordToNotification < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :medical_record, type: :uuid, index: true, foreign_key: true
  end
end
