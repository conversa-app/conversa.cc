class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :uid
      t.string :api_key
      t.string :seed_conversation_id
      t.timestamps
    end
  end
end
