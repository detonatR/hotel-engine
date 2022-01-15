# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a reviewable model' do
  subject(:model) { build(described_class.to_s.underscore.to_sym) }

  describe 'associations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end
end
