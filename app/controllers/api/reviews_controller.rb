# frozen_string_literal: true

module API
  class ReviewsController < ApplicationController
    include Filterable
    include Sortable

    before_action :authenticate_user!, only: [:create]
    before_action :set_reviewable

    def index
      @scope = @reviewable.reviews

      apply_filter if filtering?
      apply_sort   if sorting?

      render json: @scope
    end

    def create
      @review = current_user.reviews.new(review_params.merge(reviewable: @reviewable))

      if @review.save
        render json: @review
      else
        render json: { status: 'error', errors: @review.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_reviewable
      resource, id = request.path.split('/')[2, 2]
      @reviewable = resource.singularize.classify.constantize.find(id)
    end

    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def filter_by_description(value)
      if ActiveRecord::Type::Boolean.new.cast(value)
        @scope.where.not(description: nil)
      else
        @scope.where(description: nil)
      end
    end

    def filtering_attributes
      %i[rating description]
    end

    def sorting_attributes
      %i[rating]
    end
  end
end
