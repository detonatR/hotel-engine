# frozen_string_literal: true

require 'rails_helper'

class UsesProfanityValidator
  include ActiveModel::Model
  attr_accessor :content

  validates :content, profanity: true
end

RSpec.describe ProfanityValidator, type: :validator do
  subject(:uses_profanity_validator) { UsesProfanityValidator.new(content: content) }

  context 'with a blank value' do
    let(:content) { '' }

    it { is_expected.to be_valid }
  end

  context 'when the value includes profanity' do
    context 'with a paragraph' do
      context 'at the beginning' do
        let(:content) { 'frak the whale!' }

        it { is_expected.not_to be_valid }

        it 'returns an error' do
          subject.valid?
          expect(subject.errors.full_messages).to contain_exactly 'Content must not contain profanity.'
        end
      end

      context 'at the end' do
        let(:content) { 'the whale is totally gOrRaM' }

        it { is_expected.not_to be_valid }

        it 'returns an error' do
          subject.valid?
          expect(subject.errors.full_messages).to contain_exactly 'Content must not contain profanity.'
        end
      end

      context 'in the middle' do
        let(:content) { 'why the FRAK is he writing about whales?' }

        it { is_expected.not_to be_valid }

        it 'returns an error' do
          subject.valid?
          expect(subject.errors.full_messages).to contain_exactly 'Content must not contain profanity.'
        end
      end
    end

    context 'with word only' do
      let(:content) { 'frak' }

      it { is_expected.not_to be_valid }

      it 'returns an error' do
        subject.valid?
        expect(subject.errors.full_messages).to contain_exactly 'Content must not contain profanity.'
      end
    end
  end

  context 'when the value does NOT include profanity' do
    let(:content) { 'its not about the whale!' }

    it { is_expected.to be_valid }
  end
end
