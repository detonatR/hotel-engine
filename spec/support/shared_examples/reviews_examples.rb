# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a GET review index request' do
  let!(:review_1) { create(:review, rating: 2, reviewable: reviewable) }
  let!(:review_2) { create(:review, rating: 1, description: nil, reviewable: reviewable) }
  let!(:review_3) { create(:review, rating: 2, reviewable: reviewable) }

  let(:params) {}

  before { make_request }

  context 'when filtering' do
    let(:rating) { nil }
    let(:description) { nil }

    let(:params) do
      {
        filter: {
          rating: rating,
          description: description
        }
      }
    end

    context 'rating' do
      let(:rating) { 1 }

      it 'returns the reviews' do
        expect(json_response).to contain_exactly json_for(review_2)
      end
    end

    context 'description' do
      context 'when true' do
        let(:description) { true }

        it 'returns the reviews' do
          expect(json_response).to contain_exactly(
            json_for(review_1),
            json_for(review_3)
          )
        end
      end

      context 'when false' do
        let(:description) { false }

        it 'returns the reviews' do
          expect(json_response).to contain_exactly json_for(review_2)
        end
      end
    end
  end

  context 'when sorting' do
    let(:params) do
      {
        sort: {
          rating: direction
        }
      }
    end
    context 'when ASC' do
      let(:direction) { 'ASC' }

      it 'returns the reviews' do
        expect(json_response).to contain_exactly(
          json_for(review_2),
          json_for(review_1),
          json_for(review_3)
        )
      end
    end

    context 'when DESC' do
      let(:direction) { 'DESC' }

      it 'returns the reviews' do
        expect(json_response).to contain_exactly(
          json_for(review_3),
          json_for(review_1),
          json_for(review_2)
        )
      end
    end

    context 'when OTHER' do
      let(:direction) { 'dangerous' }

      it 'returns the reviews' do
        expect(json_response).to contain_exactly(
          json_for(review_2),
          json_for(review_1),
          json_for(review_3)
        )
      end
    end
  end

  context 'when sorting AND filtering' do
    let(:params) do
      {
        filter: {
          description: true,
          rating: 2
        },
        sort: {
          rating: 'desc'
        }
      }
    end

    it 'returns the reviews' do
      expect(json_response).to contain_exactly(
        json_for(review_3),
        json_for(review_1)
      )
    end
  end

  it 'returns the reviews' do
    expect(json_response).to contain_exactly(
      json_for(review_1),
      json_for(review_2),
      json_for(review_3)
    )
  end
end

RSpec.shared_examples 'a POST review request' do
  context 'when authenticated' do
    context 'when successful' do
      let(:review) { Review.last }

      let(:params) do
        {
          review: {
            rating: 3,
            description: 'Great book'
          }
        }
      end

      it 'creates the review' do
        expect { make_request }.to change(Review, :count).by(1)
      end

      it 'sets the correct attributes' do
        make_request
        expect(review).to have_attributes(rating: 3, description: 'Great book', reviewable: reviewable)
      end

      it 'returns the review' do
        make_request
        expect(json_response).to eq json_for(review)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          review: {
            rating: 10
          }
        }
      end

      before { make_request }

      it { expect(response).to have_http_status 422 }

      it 'returns errors' do
        expect(json_response[:errors]).to eq(
          {
            rating: ['must be less than or equal to 5']
          }
        )
      end
    end
  end

  context 'when NOT authenticated' do
    before { post reviews_url }

    it { expect(response).to have_http_status 401 }
  end
end
