# frozen_string_literal: true

RSpec.describe '/api/users' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all users' do
      user = create(:user)

      get api_users_path

      expect(response_hash).to eq(
        [
          {
            created_at: user.created_at.iso8601(3),
            first_name: user.first_name,
            last_name: user.last_name,
            id: user.id,
            updated_at: user.updated_at.iso8601(3),
            email: user.email,
            provider: user.provider,
            uid: user.uid
          }
        ]
      )
    end
  end

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an user' do
        user = create(:user)

        get api_user_path(user)

        expect(response_hash).to eq(
          {
            created_at: user.created_at.iso8601(3),
            first_name: user.first_name,
            last_name: user.last_name,
            id: user.id,
            updated_at: user.updated_at.iso8601(3),
            email: user.email,
            provider: user.provider,
            uid: user.uid
          }
        )
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_user_path(-1)

        expect(response).to be_not_found
      end
    end
  end
end
