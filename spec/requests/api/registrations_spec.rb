# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  let(:signup_url) { '/api/auth/' }

  describe 'POST /auth/' do
    let(:signup_params) do
      {
        email: 'user@example.com',
        password: '12345678',
        password_confirmation: '12345678',
        first_name: 'john',
        last_name: 'smith'
      }
    end

    context 'when signup params is valid' do
      before { post signup_url, params: signup_params }

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns authentication header with right attributes' do
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

      it 'returns status success' do
        expect(json_response[:status]).to eq('success')
      end

      it 'returns the user data' do
        expect(json_response[:data]).to include({ first_name: 'john', last_name: 'smith' })
      end

      it 'creates new user' do
        expect do
          post signup_url, params: signup_params.merge({ email: 'test@example.com' })
        end.to change(User, :count).by(1)
      end
    end

    context 'when signup params is invalid' do
      let(:signup_params) do
        {
          email: nil,
          password: nil,
          password_confirmation: nil,
          first_name: nil,
          last_name: nil
        }
      end

      before { post signup_url, params: signup_params }

      it 'returns unprocessable entity 422' do
        expect(response.status).to eq 422
      end

      it 'returns an error' do
        expect(json_response[:errors]).to eq(
          {
            password: ["can't be blank"],
            email: ["can't be blank"],
            first_name: ["can't be blank"],
            last_name: ["can't be blank"],
            full_messages: ["Password can't be blank", "Email can't be blank", "First name can't be blank",
                            "Last name can't be blank"]
          }
        )
      end
    end
  end

  describe 'PUT /auth' do
    let(:headers) do
      {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }
    end

    let(:login_params) do
      {
        email: user.email,
        password: user.password
      }
    end

    let(:params) do
      {
        first_name: first_name
      }
    end

    let(:user) { create(:user) }

    before { post '/api/auth/sign_in', params: login_params, as: :json }

    context 'when successful' do
      let(:first_name) { 'James' }

      it 'updates an existing user' do
        put signup_url, params: params, headers: headers

        expect(user.reload.first_name).to eq(params[:first_name])
      end

      it 'returns the updated user' do
        put signup_url, params: params, headers: headers

        expect(json_response[:data]).to include(params)
      end
    end

    context 'when not successful' do
      let(:first_name) { '' }

      it 'returns an error' do
        put signup_url, params: params, headers: headers

        expect(json_response[:errors]).to eq(
          {
            first_name: ["can't be blank"],
            full_messages: ["First name can't be blank"]
          }
        )
      end
    end
  end
end
