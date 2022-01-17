# frozen_string_literal: true

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }

  describe 'GET index' do
    let(:make_request) { get reviews_url, params: params }

    context 'when resource is a Book' do
      it_behaves_like 'a GET review index request' do
        include_context 'a reviewable resource', model: Book
      end
    end

    context 'when resource is an Author' do
      it_behaves_like 'a GET review index request' do
        include_context 'a reviewable resource', model: Author
      end
    end
  end

  describe 'POST' do
    let(:make_request) do
      login
      post reviews_url, params: params, headers: auth_headers
    end

    context 'when resource is a Book' do
      it_behaves_like 'a POST review request' do
        include_context 'a reviewable resource', model: Book
      end
    end

    context 'when resource is an Author' do
      it_behaves_like 'a POST review request' do
        include_context 'a reviewable resource', model: Author
      end
    end
  end

  def json_for(record)
    {
      id: record.id,
      reviewable_type: record.reviewable_type,
      reviewable_id: record.reviewable_id,
      user_id: record.user_id,
      rating: record.rating,
      description: record.description,
      created_at: record.created_at.iso8601(3),
      updated_at: record.updated_at.iso8601(3)
    }
  end
end
