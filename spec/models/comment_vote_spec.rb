# == Schema Information
#
# Table name: comment_votes
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  comment_id :bigint(8)
#  vote       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CommentVote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
