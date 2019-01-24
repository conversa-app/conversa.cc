# == Schema Information
#
# Table name: comments
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  conversation_id :bigint(8)
#  content         :string
#  votable         :boolean
#  active          :boolean
#  tid             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :comment do
    
  end
end
