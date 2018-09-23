# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.string :essence, null: false
      t.string :fingerprint
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
