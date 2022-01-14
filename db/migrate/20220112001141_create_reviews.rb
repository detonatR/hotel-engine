# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true
      t.belongs_to :user, foreign_key: true
      t.integer :rating, index: true
      t.text :description, index: true

      t.timestamps
    end
  end
end
