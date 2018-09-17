# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.references :user, index: true, foreign_key: true, null: false, type: :uuid
      t.string :token_hash, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
