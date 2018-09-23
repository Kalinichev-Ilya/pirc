# frozen_string_literal: true

class AddAccessTokensToUsers < ActiveRecord::Migration[5.2]
    def change
      add_reference :users, :access_token, foreign_key: true, type: :uuid
    end
  end
