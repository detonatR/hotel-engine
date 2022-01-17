# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:reviewable) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5) }

    it 'uses the ProfanityValidator' do
      expect(described_class.validators.map(&:class)).to include(ProfanityValidator)
    end

    describe '#user' do
      subject(:review) { build(:review, reviewable: reviewable) }

      context 'when the reviewable is a Book' do
        let(:reviewable) { create(:book) }

        context 'when the user has no existing reviews for the book' do
          it { is_expected.to be_valid }
        end

        context 'when the user has an existing review for the book' do
          let!(:review) { create(:review, reviewable: reviewable) }

          it { is_expected.not_to be_valid }

          it 'has error message' do
            subject.valid?
            expect(subject.errors.full_messages).to contain_exactly "User can't have more than one review per book."
          end
        end
      end

      context 'when the reviewable is NOT a Book' do
        let(:reviewable) { create(:author) }

        it { is_expected.to be_valid }
      end
    end
  end

  describe 'callbacks' do
    subject(:review) { build(:review, reviewable: reviewable) }

    describe 'update_averages' do
      context 'when reviewable is a book' do
        let(:reviewable) { create(:book) }

        it 'runs the callback' do
          expect(reviewable).to receive(:update_average_rating!)
          review.run_callbacks(:save)
        end
      end

      context 'when reviewable is NOT a book' do
        let(:reviewable) { create(:author) }

        it 'does nothing' do
          expect(review).to receive(:update_averages).and_return(nil)
          review.run_callbacks(:save)
        end
      end
    end
  end

  describe 'factories' do
    it 'has a valid factory' do
      review = build_stubbed(:review)
      expect(review).to be_valid
    end
  end
end
