# frozen_string_literal: true

class RenameChannelOptionsToMemberships < ActiveRecord::Migration[5.2]
  def change
    rename_table :channel_options, :memberships
  end
end
