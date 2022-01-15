# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validate :number_of_reviews

  private

  def number_of_reviews
    return unless reviewable.is_a?(Book)
    return unless user.reviews.where(reviewable: reviewable).exists?

    errors.add(:user, "can't have more than one review per book.")
  end
end
