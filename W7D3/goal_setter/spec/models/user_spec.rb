require 'rails_helper'

RSpec.describe User, type: :model do
  
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}

  it {should validate_uniqueness_of(:email)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_uniqueness_of(:session_token)}

  subject(:user) {FactoryBot.create(:user)}

  describe 'ensure_session_token' do
    it 'assigns a session token if none is given' do
      expect(FactoryBot.create(:user).session_token).to_not be_nil
    end
  end

  describe 'password encryption' do
    it 'does not save passwords to the database' do
      FactoryBot.create(:user, username: 'Michelle_AA')
      user = User.find_by(username: 'Michelle_AA')
      expect(user.password).to_not be('password')
    end
    it 'encrypts password using BCrypt' do 
      expect(BCrypt::Password).to receive(:create).with('password')
      FactoryBot.build(:user,password:'password')
    end
  end



end

