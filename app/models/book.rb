# frozen_string_literal: true

class Book < ApplicationRecord
  include Reviewable

  belongs_to :author

  validates :title, :description, presence: true

  def update_average_rating!
    count = reviews.average(:rating)
    update_column(:average_rating, count)
  end
end
