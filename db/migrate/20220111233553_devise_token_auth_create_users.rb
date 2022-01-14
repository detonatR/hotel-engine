# frozen_string_literal: true

class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.1]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      t.json :tokens
    end

    add_index :users, %i[uid provider], unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
