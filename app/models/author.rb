# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :description, presence: true
end
