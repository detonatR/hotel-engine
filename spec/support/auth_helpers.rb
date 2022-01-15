# frozen_string_literal: true

module Requests
  # Requests helper for authentication headers
  module AuthHelpers
    def login
      post '/api/auth/sign_in', params: { email: user.email, password: user.password }, as: :json
    end

    def auth_headers
      {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }
    end
  end
end
