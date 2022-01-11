# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
end
