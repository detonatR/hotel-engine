# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :first_name, :last_name, presence: true
end
