# frozen_string_literal: true

class AddIndexToMessages < ActiveRecord::Migration[5.2]
  def change
    add_index(:messages, [:created_at], name: 'messages_created_at_by_desc', order: { created_at: :desc })
  end
end
