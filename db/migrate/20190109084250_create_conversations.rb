class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :auth_needed_to_vote,
        :auth_needed_to_write,
        :auth_opt_fb,
        :auth_opt_tw,
        :auth_opt_allow_3rdparty,
        :auth_opt_fb_computed,
        :auth_opt_tw_computed

      t.belongs_to :user, :organization
      t.boolean :is_active, :is_draft, :is_public, :profanity_filter, :spam_filter, default: true

      t.boolean :is_anon, :is_data_open, :is_slack, 
      :lti_users_only, :owner_sees_participation_stats, 
      :prioritize_seed, :strict_moderation, 
      :use_xid_whitelist, default: false
      t.string :topic, :bgcolor, :help_bgcolor, :help_color, :help_type, :context, :email_domain
      t.string :conversation_id
      t.integer :course_id, :participant_count, :socialbtn_type, :subscribe_type, :upvotes,
      :vis_type, :write_hint_type, :write_type
      t.string :dataset_explanation, :link_url, :parent_url, :style_btn
      t.text :description, :topic
      t.timestamps
    end
  end
end

