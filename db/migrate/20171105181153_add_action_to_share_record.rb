class AddActionToShareRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :share_records, :action, :string
  end
end
