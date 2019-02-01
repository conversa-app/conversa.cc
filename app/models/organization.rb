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

  after_create :create_dummy_conversation

  private

  def create_dummy_conversation
    url = Rails.application.credentials.production[:polis] + "/conversations"
    response = Excon.post(url,
      :body => "polisApiKey=#{self.api_key}",
      :headers => { "Content-Type" => "application/x-www-form-urlencoded" }
    )
    self.seed_conversation_id = JSON.parse(response.body)['conversation_id']
    save
  end

end
