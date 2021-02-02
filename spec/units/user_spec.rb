require './lib/user.rb'

describe User do

  describe '.create' do
    let(:name) { 'Bob' }
    let(:email) { 'bob@gmail.com' }
    let(:username) { 'bobby007' }
    let(:password) { 'jamesbond' }
    let(:new_user) { described_class.create(name, email, username, password) }
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
  end

end
