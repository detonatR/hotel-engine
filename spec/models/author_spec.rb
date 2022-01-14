# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      author = build_stubbed(:author)
      expect(author).to be_valid
    end
  end
end
