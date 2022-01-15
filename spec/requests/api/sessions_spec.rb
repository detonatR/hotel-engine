# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let(:user) { create(:user) }
  let(:signin_url) { '/api/auth/sign_in' }
  let(:signout_url) { '/api/auth/sign_out' }

  describe 'POST /auth/sign_in' do
    context 'when login params is valid' do
      before { login }

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns access-token in authentication header' do
        expect(response.headers['access-token']).to be_present
      end

      it 'returns client in authentication header' do
        expect(response.headers['client']).to be_present
      end

      it 'returns expiry in authentication header' do
        expect(response.headers['expiry']).to be_present
      end

      it 'returns uid in authentication header' do
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when login params is invalid' do
      before { post signin_url }

      it 'returns unathorized status 401' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /auth/sign_out' do
    it 'returns status 200' do
      login
      delete signout_url, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end
end
