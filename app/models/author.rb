# frozen_string_literal: true

class Author < ApplicationRecord
  include Reviewable

  has_many :books, dependent: :destroy

  validates :description, presence: true
end
