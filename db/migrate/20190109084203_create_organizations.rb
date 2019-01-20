class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :uid
      t.timestamps
    end
  end
end
