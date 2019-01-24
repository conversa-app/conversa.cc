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

FactoryBot.define do
  factory :comment_vote do
    
  end
end
