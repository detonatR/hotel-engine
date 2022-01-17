# frozen_string_literal: true

class AddAverageRatingToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :average_rating, :integer, default: 0, null: false
  end
end
