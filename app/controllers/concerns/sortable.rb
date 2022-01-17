# frozen_string_literal: true

module Sortable
  def apply_sort
    sorting_params.each do |sort_input|
      @scope = apply_sort_input(sort_input)
    end
  end

  def apply_sort_input(sort_input)
    field, value = sort_input
    return @scope if value.nil?

    @scope.order("#{field} #{direction_from(value)}")
  end

  private

  def direction_from(value)
    %w[asc desc].include?(value.downcase) ? value : 'asc'
  end

  def sorting_params
    params.require(:sort).permit(sorting_attributes)
  end

  def sorting?
    params[:sort].present?
  end
end
