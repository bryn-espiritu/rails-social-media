class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.string :role
      t.string :banner
      t.references :user
      t.references :owner
      t.timestamps
    end
  end
end
