class CreateCommentVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_votes do |t|
      t.belongs_to :user
      t.belongs_to :comment
      t.integer :vote, :limit => 1
      t.timestamps
      t.index ['user_id', :comment_id], name: 'index_comments_cid_and_uId', using: :btree
    end
  end
end
