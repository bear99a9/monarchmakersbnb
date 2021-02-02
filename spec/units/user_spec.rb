require './lib/user.rb'

describe User do

  describe '.create' do
    let(:name) { 'Ollie' }
    let(:email) { 'goodjobOllie@gmail.com' }
    let(:username) { 'welldoneOllie' }
    let(:password) { 'Ollieisgood' }
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
    it 'adds an object to the users table in our db' do
      results = persisted_data(id: new_user.id, table: 'users')
      expect(new_user.id).to eq results['id']
    end
    describe 'the data added' do
      it 'has the right data' do
        results = persisted_data(id: new_user.id, table: 'users')
        expect(results['name']).to eq name
        expect(results['email']).to eq email
        expect(results['username']).to eq username
      end
    end
  end

end
