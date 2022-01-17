# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :description, profanity: true

  validate :number_of_reviews

  after_save :update_averages

  private

  def update_averages
    reviewable.update_average_rating! if book?
  end

  def number_of_reviews
    return unless book?
    return unless user.reviews.where(reviewable: reviewable).exists?

    errors.add(:user, "can't have more than one review per book.")
  end

  def book?
    reviewable.is_a?(Book)
  end
end
