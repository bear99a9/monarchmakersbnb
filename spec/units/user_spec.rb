require './lib/user.rb'
require 'bcrypt'

describe User do
  let(:name) { 'Ollie' }
  let(:email) { 'goodjobOllie@gmail.com' }
  let(:username) { 'welldoneOllie' }
  let(:password) { 'Ollieisgood' }
  let(:results) { persisted_data(id: new_user.id, table: 'users') }
  subject(:new_user) { described_class.create(name: name, email: email, username: username, password: password) }

  describe '.create' do
    it 'returns a User object' do
      expect(new_user).to be_a(User)
    end
    it 'returns an object with the right name' do
      expect(new_user.name).to eq name
    end
    it 'returns an object with the right email address' do
      expect(new_user.email).to eq email
    end
    it 'returns an object with the right username' do
      expect(new_user.username).to eq username
    end
    it 'does not have a password attribute' do
      expect(new_user).not_to respond_to(:password)
    end
    it 'adds an object to the users table in our db' do
      expect(new_user.id).to eq results['id']
    end
    describe 'the data added' do
      it 'has the right data' do
        expect(results['name']).to eq name
        expect(results['email']).to eq email
        expect(results['username']).to eq username
        expect(BCrypt::Password.new(results['password'])).to eq password
      end
      it 'hashes the password' do
        expect(results['password'].length).not_to eq password.length
      end
    end
  end

  describe '.authenticate' do
    before do
      new_user
    end

    context 'Happy Path: When passed correct email and password' do
      it 'returns true' do
        expect(described_class.authenticate(email: email, password: password)).to eq true
      end
    end

    context 'Unhappy Path: When passed incorrect email and password' do
      let(:wrong_email) { 'badjobOllie@gmail.com' }
      let(:wrong_password) { 'Ollieisbad' }

      it 'returns false when incorrect email' do
        expect(described_class.authenticate(email: wrong_email, password: password)).to eq false
      end

      it 'returns false when incorrect password' do
        expect(described_class.authenticate(email: email, password: wrong_password)).to eq false
      end

    end
  end

  describe ".find" do
    it "finds a user based on user id" do
      user = User.create(name: "Anna", email: "anna@gmail.com", username: "acav", password: "password123")
      result = User.find(id: user.id)
      expect(result.email).to eq "anna@gmail.com"
    end
  end
end
