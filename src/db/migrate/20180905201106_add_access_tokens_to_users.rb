# frozen_string_literal: true

class AddAccessTokensToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :access_tokens, :user, foreign_key: true, type: :uuid
  end
end
