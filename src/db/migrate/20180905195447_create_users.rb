# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'

    create_table :users, id: :uuid do |t|
      t.string :username, length: { in: 4..15 }, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
