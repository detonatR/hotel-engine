# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'a reviewable resource' do |model:|
  let(:model_name) { model.to_s.underscore }
  let(:reviewable) { create(model_name.to_sym) }
  let(:reviews_url) { "/api/#{model_name.pluralize}/#{reviewable.id}/reviews" }
end
