# == Schema Information
#
# Table name: conversations
#
#  id                             :bigint(8)        not null, primary key
#  auth_needed_to_vote            :string
#  auth_needed_to_write           :string
#  auth_opt_fb                    :string
#  auth_opt_tw                    :string
#  auth_opt_allow_3rdparty        :string
#  auth_opt_fb_computed           :string
#  auth_opt_tw_computed           :string
#  user_id                        :bigint(8)
#  organization_id                :bigint(8)
#  is_active                      :boolean          default(TRUE)
#  is_draft                       :boolean          default(TRUE)
#  is_public                      :boolean          default(TRUE)
#  profanity_filter               :boolean          default(TRUE)
#  spam_filter                    :boolean          default(TRUE)
#  is_anon                        :boolean          default(FALSE)
#  is_data_open                   :boolean          default(FALSE)
#  is_slack                       :boolean          default(FALSE)
#  lti_users_only                 :boolean          default(FALSE)
#  owner_sees_participation_stats :boolean          default(FALSE)
#  prioritize_seed                :boolean          default(FALSE)
#  strict_moderation              :boolean          default(FALSE)
#  use_xid_whitelist              :boolean          default(FALSE)
#  topic                          :text
#  bgcolor                        :string
#  help_bgcolor                   :string
#  help_color                     :string
#  help_type                      :string
#  context                        :string
#  email_domain                   :string
#  conversation_id                :string
#  course_id                      :integer
#  participant_count              :integer
#  socialbtn_type                 :integer
#  subscribe_type                 :integer
#  upvotes                        :integer
#  vis_type                       :integer
#  write_hint_type                :integer
#  write_type                     :integer
#  dataset_explanation            :string
#  link_url                       :string
#  parent_url                     :string
#  style_btn                      :string
#  description                    :text
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
