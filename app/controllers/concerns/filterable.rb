# frozen_string_literal: true

module Filterable
  def apply_filter
    filtering_params.each do |filter_input|
      @scope = apply_filter_input(filter_input)
    end
  end

  def apply_filter_input(filter_input)
    attribute, value = filter_input
    return @scope if value.nil?

    custom_filter = "filter_by_#{attribute}".to_sym

    @scope = if respond_to?(custom_filter, true)
               send(custom_filter, value)
             else
               @scope.where(Hash[*filter_input])
             end
  end

  private

  def filtering_params
    params.require(:filter).permit(filtering_attributes)
  end

  def filtering?
    params[:filter].present?
  end
end
