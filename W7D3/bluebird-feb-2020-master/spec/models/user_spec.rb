require 'rails_helper'

RSpec.describe User, type: :model do

    # let(:invalid_user) { User.new(username: '', password: 'password') }

    # it 'validates the presence of an email' do
    #     expect(invalid_user).to_not be_valid
    # end

    #using shoulda_matchers to test validations
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    # it { should validate_presence_of(:session_token) } failing because of our ensure_session_token method

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }

    # for uniqueness, we need a subject created
    # subject(:user) { User.create(
    #     username: 'rayzah_blaydes',
    #     email: 'down_undah@aa.io',
    #     age: 70,
    #     political_affiliation: 'appacademy',
    #     password: 'dingos'
    # )}

    subject(:user) { FactoryBot.create(:user) } #using for testing the uniqueness of, which is looking for a subject

    # FactoryBot.build => User.new
    # FactoryBot.create => User.new + user.save

    describe 'ensure_sesion_token' do
        it 'assigns a session token if none is given' do
            expect(FactoryBot.create(:user).session_token).to_not be_nil
        end
    end

    # shoulda-matcher for associations
    it { should have_many(:chirps) }


    describe 'password encryption' do
        it 'does not save passwords to the database' do
            FactoryBot.create(:user, username: 'rayzah_blaydes') # overwriting the random username in FactoryBot so that we can query
            user = User.find_by(username: 'rayzah_blaydes')
            expect(user.password).to_not be('password')
        end

        it 'encrypts password using BCrypt' do
            expect(BCrypt::Password).to receive(:create).with('123456') #goes first because you want to set the expectation
            FactoryBot.build(:user, password: '123456') # building a user "triggers" our password= method, which in turn invokes the BCrypt
        end
    end

end