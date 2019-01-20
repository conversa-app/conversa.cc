# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                        :bigint(8)        not null, primary key
#  first_name                :string
#  last_name                 :string
#  username                  :string
#  email                     :string
#  password_digest           :string           default(""), not null
#  enabled                   :boolean          default(TRUE)
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  password_token            :string
#  time_zone                 :string           default("UTC")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'rails_helper'

require 'rails_helper'

describe Admin do
  it 'includes SessionMethodIncludes' do
    expect(subject).to be_kind_of(SessionMethodIncludes)
  end

  it 'includes Admin' do
    expect(subject).to be_kind_of(Admin)
  end

  describe 'Attributes' do
    it 'can read/write to :password' do
      subject.password = 'pwd'
      expect(subject.password).to eq('pwd')
    end
  end

  describe 'Validations' do
    it 'is valid with a valid first_name, last_name, username, email, and password' do
      # Tests that *only* these validations are required
      # Use #new instead of FactoryBot attributes (which might have more)
      subject.first_name = 'first'
      subject.last_name = 'last'
      subject.username = 'username'
      subject.email = 'someone@somewhere.com'
      subject.password = 'Password1'
      expect(subject.valid?).to be true
    end

    it do
      is_expected.to validate_length_of(:first_name)
        .is_at_least(3)
    end
    it do
      is_expected.to validate_length_of(:last_name)
        .is_at_least(3)
    end
    it do
      is_expected.to validate_length_of(:username)
        .is_at_least(5)
    end

    it 'username uniqueness should not be case sensitive' do
      @admin = FactoryBot.create(:admin, username: 'testuser')
      @admin2 = FactoryBot.build(:admin, username: @admin.username.upcase)
      expect(@admin2.valid?).to be_falsy
      expect(@admin2.errors[:username].to_s).to include 'already exists'
    end

    it 'should be invalid without a unique email' do
      @admin = FactoryBot.create(:admin, email: 'test@test.com')
      @admin2 = FactoryBot.build(:admin, email: @admin.email)
      expect(@admin2.valid?).to be_falsy
      expect(@admin2.errors[:email].to_s).to include 'already has an account'
    end

    it 'email uniqueness should not be case sensitive' do
      @admin = FactoryBot.create(:admin, email: 'test@test.com')
      @admin2 = FactoryBot.build(:admin, email: @admin.email.upcase)
      expect(@admin2.valid?).to be_falsy
      expect(@admin2.errors[:email].to_s).to include 'already has an account'
    end

    it { is_expected.not_to allow_value('', 'someone@somewhere').for(:email) }
    it { is_expected.to allow_value('someone@somewhere.com').for(:email) }

    it { is_expected.to validate_confirmation_of(:email) }

    it do
      is_expected.to validate_length_of(:password)
        .is_at_least(8)
    end

    it { is_expected.to allow_value('123abc!!').for(:password) }
    it { is_expected.to allow_value('abc123!!').for(:password) }
    it { is_expected.to allow_value('a1b2c3!!').for(:password) }
  end

  describe '.authenticate' do
    before(:context) do
      @admin = FactoryBot.create(:admin, password: '123password', password_confirmation: '123password')
    end

    after(:context) { @admin.destroy }

    it 'returns an admin with correct username and password' do
      result = Admin.authenticate(@admin.username, '123password')
      expect(result).to eq(@admin)
    end

    it 'returns false if a username does not exist' do
      result = Admin.authenticate('fake_username', '123password')
      expect(result).to be nil
    end

    it 'returns false with a valid username and invalid password' do
      result = Admin.authenticate(@admin.username, 'incorrect')
      expect(result).to be nil
    end
  end

  describe '#full_name' do
    it 'returns first and last name with a space between' do
      subject.first_name = 'John'
      subject.last_name = 'Smith'
      expect(subject.full_name).to eq('John Smith')
    end
  end
end
