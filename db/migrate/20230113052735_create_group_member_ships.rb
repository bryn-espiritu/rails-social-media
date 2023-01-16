class CreateGroupMemberShips < ActiveRecord::Migration[7.0]
  def change
    create_table :group_member_ships do |t|
      t.references :user
      t.references :group
      t.timestamps
    end
  end
end
