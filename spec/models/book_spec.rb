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

  describe 'factories' do
    it 'has a valid factory' do
      book = build_stubbed(:book)
      expect(book).to be_valid
    end
  end
end
