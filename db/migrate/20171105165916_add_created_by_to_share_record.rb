class AddCreatedByToShareRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :share_records, :created_by, :string
  end
end
