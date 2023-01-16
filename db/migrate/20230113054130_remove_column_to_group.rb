class RemoveColumnToGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :role
  end
end
