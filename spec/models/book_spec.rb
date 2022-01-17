# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it_behaves_like 'a reviewable model'

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#update_average_rating!' do
    subject(:book) { create(:book) }

    let!(:reviews) do
      [
        create(:review, reviewable: book, rating: 2),
        create(:review, reviewable: book, rating: 1),
        create(:review, reviewable: book, rating: 4)
      ]
    end

    it 'sets the count' do
      expect(book.average_rating).to eq 2
    end
  end

  describe 'factories' do
    it 'has a valid factory' do
      book = build_stubbed(:book)
      expect(book).to be_valid
    end
  end
end
