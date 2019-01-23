# == Schema Information
#
# Table name: organizations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  uid        :integer
#  api_key    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord

  has_many :users
  has_many :conversations
  
end
