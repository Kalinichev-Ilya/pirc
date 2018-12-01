# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.string :essence_hash, null: false, unique: true
      t.string :refresh_token_hash, null: false, unique: true
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
