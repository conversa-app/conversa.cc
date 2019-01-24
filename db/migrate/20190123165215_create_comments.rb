class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :conversation
      t.string :content
      t.boolean :votable, :active, default: true
      t.integer :tid
      t.timestamps
    end
  end
end
