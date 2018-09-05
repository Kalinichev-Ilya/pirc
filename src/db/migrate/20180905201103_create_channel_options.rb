class CreateChannelOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :channel_options, id: :uuid do |t|
      t.references :user, index: true, foreign_key: true, null: false, type: :uuid
      t.references :channel, index: true, foreign_key: true, null: false, type: :uuid
      t.boolean :is_favorite, default: false, null: false

      t.timestamps
    end

    add_index :channel_options, %i[user_id channel_id], unique: true
  end
end
