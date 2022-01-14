# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author

  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :title, :description, presence: true
end
