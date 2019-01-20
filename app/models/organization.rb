class Organization < ApplicationRecord

  has_many :users
  has_many :conversations
  
end
